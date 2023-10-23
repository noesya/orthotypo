module Orthotypo
  class Composer
    attr_reader :string, :ortho

    SPACE = ' '.freeze
    NBSP = ' '.freeze
    NNBSP = ' '.freeze
    PRECIOUS_TOKEN = 'orthotypopreciousthing'

    def initialize(string, html: nil)
      @string = string
      @html = html
      parse
    end

    protected

    def chars_with_space_before
      []
    end

    def chars_with_space_before_after_digit
      [
        '%'
      ]
    end

    def chars_with_space_after
      [
        ',',
        '.'
      ]
    end
    
    def chars_with_space_around
      []
    end

    def chars_with_no_space_around
      []
    end

    def pairs_with_space_around
      []
    end
    
    def pairs_with_no_space_around
      []
    end

    def chars_with_no_space_around_between_digits
      [
        '/',
        ':'
      ]
    end

    def chars_in_numbers
      [
        '.', 
        ',',
        '/',
        ':'
      ]
    end

    def is_html?
      # TODO contains tags?
      @html || contains_html_entities?
    end

    def contains_html_entities?
      @contains_html_entities ||= html_entities.decode(string) != string
    end

    def prepare_ortho
      @ortho = string.dup
      # @ortho = html_entities.decode(@ortho) if contains_html_entities?
      @nokogiri = Nokogiri::HTML.fragment @ortho
    end

    def clean_ortho
      @ortho = @nokogiri.to_s
      # @ortho = html_entities.encode(@ortho) if contains_html_entities?
    end

    def parse
      prepare_ortho
      preserve_precious_things
      # Chars
      parse_chars_with_space_before
      parse_chars_with_space_before_after_digit
      parse_chars_with_space_after
      parse_chars_with_space_around
      parse_chars_with_no_space_around
      # Pairs
      parse_pairs_with_space_around
      parse_pairs_with_no_space_around
      # Numbers
      parse_chars_in_numbers
      # 
      clean_ortho
      restore_precious_things
    end

    def preserve_precious_things
      @precious_things = []
      @nokogiri.traverse do |node|
        next unless node.text?
        new_content = node.content.split(SPACE).map { |fragment|
          if Analyzer::precious?(fragment)
            token = "#{PRECIOUS_TOKEN}#{@precious_things.length}"
            @precious_things << fragment
            token
          else
            fragment
          end
        }.join(SPACE)
        node.content = new_content
      end
    end

    def restore_precious_things
      @precious_things.each_with_index do |value, index|
        @ortho.gsub! "#{PRECIOUS_TOKEN}#{index}", value
      end
    end

    def parse_chars_with_space_before
      chars_with_space_before.each do |char|
        # Espace normal avant -> espace fine insécable avant
        fix(SPACE + char, NNBSP + char)
        # Pas d'espace avant -> espace fine insécable avant
        fix(/([[:alpha:]])[#{char}]/, "\\1" + NNBSP + char)
      end
    end

    def parse_chars_with_space_before_after_digit
      chars_with_space_before_after_digit.each do |char|
        fix(/([[:digit:]])[#{char}]/, "\\1" + NNBSP + char)
      end
    end

    def parse_chars_with_space_after
      chars_with_space_after.each do |char|
        # Espace avant -> pas d'espace avant 
        fix(SPACE + char, char)
        # Pas d'espace après -> espace après
        fix(/[#{char}]([[:alpha:]])/, char + SPACE + "\\1")
      end
    end

    def parse_chars_with_space_around
      chars_with_space_around.each do |char|
        # Espace normal avant -> espace fine insécable avant
        fix(SPACE + char, NNBSP + char)
        # Pas d'espace avant -> espace fine insécable avant
        fix(/([[:alpha:]])[#{char}]/, "\\1" + NNBSP + char)
      end
    end

    def parse_chars_with_no_space_around
      chars_with_no_space_around.each do |char|
        # Espace avant -> pas d'espace avant 
        fix(SPACE + char, char)
        # Espace après -> pas d'espace après 
        fix(char + SPACE, char)
      end
    end

    def parse_pairs_with_space_around
      pairs_with_space_around.each do |marks|
        opening = marks.chars.first
        closing = marks.chars.last
        # Espace normal -> espace fine insécable
        fix(opening + SPACE, opening + NNBSP)
        fix(SPACE + closing, NNBSP + closing)
        # Pas d'espace -> espace fine insécable
        fix(/[#{opening}]([^[:space:]])/, opening + NNBSP + "\\1")
        fix(/([^[:space:]])[#{closing}]/, "\\1" + NNBSP + closing)
      end
    end

    def parse_pairs_with_no_space_around
      pairs_with_no_space_around.each do |marks|
        opening = marks.chars.first
        closing = marks.chars.last
        # Espace -> pas d'espace
        fix(opening + SPACE, opening)
        fix(SPACE + closing, closing)
      end
    end

    def parse_chars_in_numbers
      chars_in_numbers.each do |char|
        fix(/([[:digit:]])[[:space:]][#{char}]([[:digit:]])/, "\\1" + char + "\\2")
        fix(/([[:digit:]])[[:space:]][#{char}][[:space:]]([[:digit:]])/, "\\1" + char + "\\2")
        fix(/([[:digit:]])[#{char}][[:space:]]([[:digit:]])/, "\\1" + char + "\\2")
      end
    end

    def html_entities
      @html_entities ||= HTMLEntities.new(:expanded)
    end

    def fix(bad, good)
      @nokogiri.traverse do |node|
        next unless node.text?
        node.content = node.content.gsub(bad, good)
      end
    end
  end
end