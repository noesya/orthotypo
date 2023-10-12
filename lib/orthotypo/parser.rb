module Orthotypo
  class Parser
    attr_reader :string, :ortho

    SPACE = ' '.freeze
    NBSP = ' '.freeze
    NNBSP = ' '.freeze
    PUNCTUATION_DOUBLE = ';:!?'.freeze
    PUNCTUATION_SIMPLE = ',.'.freeze
    QUOTATION_MARKS_WITH_SPACE_AROUND = [
      '«»'
    ].freeze
    QUOTATION_MARKS_WITH_NO_SPACE_AROUND = [
      '“”',
      '‘’',
      '‹›',
      '""',
      "''"
    ].freeze

    def initialize(string)
      @string = string
      @ortho = string.dup
      parse
    end

    protected

    def parse
      parse_punctuation_double
      parse_punctuation_simple
      parse_quotation_marks_with_space_around
      parse_quotation_marks_with_no_space_around
    end

    def parse_punctuation_double
      PUNCTUATION_DOUBLE.each_char do |char|
        # Espace normal -> espace fine insécable
        fix(SPACE + char, NNBSP + char)
        # Pas d'espace -> espace fine insécable
        fix(/([[:alnum:]])[#{char}]/, "\\1" + NNBSP + char)
      end
    end

    def parse_punctuation_simple
      PUNCTUATION_SIMPLE.each_char do |char|
        # Espace normal -> espace fine insécable
        fix(SPACE + char, char)
      end
    end

    def parse_quotation_marks_with_space_around
      QUOTATION_MARKS_WITH_SPACE_AROUND.each do |marks|
        opening = marks.chars.first
        closing = marks.chars.last
        # Espace normal -> espace insécable
        fix(opening + SPACE, opening + NBSP)
        fix(SPACE + closing, NBSP + closing)
        # Pas d'espace -> espace insécable
        fix(/[#{opening}]([[:alnum:]])/, opening + NBSP + "\\1")
        fix(/([[:alnum:]])[#{closing}]/, "\\1" + NBSP + closing)
      end
    end

    def parse_quotation_marks_with_no_space_around
      QUOTATION_MARKS_WITH_NO_SPACE_AROUND.each do |marks|
        opening = marks.chars.first
        closing = marks.chars.last
        # Espace -> pas d'espace
        fix(opening + SPACE, opening)
        fix(SPACE + closing, closing)
      end
    end

    def fix(bad, good)
      @ortho.gsub! bad, good
    end
  end
end