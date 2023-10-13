module Orthotypo
  class Parser
    attr_reader :string, :ortho

    SPACE = ' '.freeze
    NBSP = ' '.freeze
    NNBSP = ' '.freeze

    def initialize(string, locale = nil, html = nil)
      @string = string
      @locale = locale
      determine_locale
      @html = html
      determine_html
      @ortho = string.dup
      parse
    end

    protected

    def chars_with_space_before
      [
        '%'
      ]
    end

    def chars_with_space_after
      [
        ',',
        '.',
        '...',
        '…'
      ]
    end
    
    def chars_with_space_around
      [
        ';',
        ':',
        '!',
        '?'
      ]
    end

    def chars_with_no_space_around
      [
        "'",
        '’',
        'ʼ'
      ]
    end

    def pairs_with_space_around
      [
        '«»'
      ]
    end
    
    def pairs_with_no_space_around
      [
        '“”',
        '‘’',
        '‹›',
        '""',
        "''",
        "()",
        "{}",
        "[]"
      ]
    end

    def determine_locale
      # TODO (avec I18n si présent)
    end

    def determine_html
      # TODO
    end

    def parse
      # Chars
      parse_chars_with_space_before
      parse_chars_with_space_after
      parse_chars_with_space_around
      parse_chars_with_no_space_around
      # Pairs
      parse_pairs_with_space_around
      parse_pairs_with_no_space_around
      # Numbers
      parse_numbers
    end

    def parse_chars_with_space_before
      chars_with_space_before.each do |char|
        # Espace normal avant -> espace fine insécable avant
        fix(SPACE + '%', NNBSP + '%')
        # Pas d'espace avant -> espace fine insécable avant
        fix(/([[:alnum:]])%/, "\\1" + NNBSP + '%')
      end
    end

    def parse_chars_with_space_after
      chars_with_space_after.each do |char|
        # Espace avant -> pas d'espace avant 
        fix(SPACE + char, char)
        # Pas d'espace après -> espace après
        fix(/[#{char}]([[:alnum:]])/, char + SPACE + "\\1")
      end
    end

    def parse_chars_with_space_around
      chars_with_space_around.each do |char|
        # Espace normal avant -> espace fine insécable avant
        fix(SPACE + char, NNBSP + char)
        # Pas d'espace avant -> espace fine insécable avant
        fix(/([[:alnum:]])[#{char}]/, "\\1" + NNBSP + char)
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

    def parse_numbers
      ['.', ','].each do |char|
        fix(/([[:digit:]])[#{char}][[:space:]]([[:digit:]])/, "\\1" + char + "\\2")
      end
    end

    def fix(bad, good)
      @ortho.gsub! bad, good
    end
  end
end