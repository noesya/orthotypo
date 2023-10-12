module Orthotypo
  class Parser
    attr_reader :string, :ortho

    SPACE = ' '.freeze
    NNBSP = ' '.freeze
    PUNCTUATION_DOUBLE = ';:!?'.freeze
    PUNCTUATION_SIMPLE = ',.'.freeze

    def initialize(string)
      @string = string
      @ortho = string.dup
      parse
    end

    protected

    def parse
      parse_punctuation_double
      parse_punctuation_simple
    end

    def parse_punctuation_double
      PUNCTUATION_DOUBLE.each_char do |char|
        # Espace normal -> espace fine insécable
        correct = NNBSP + char
        wrong_space = SPACE + char
        @ortho.gsub! wrong_space, correct
        # Pas d'espace -> espace fine insécable
        correct = "\\1" + NNBSP + char
        no_space = /(\w)[#{char}]/
        @ortho.gsub! no_space, correct
      end
    end

    def parse_punctuation_simple
      PUNCTUATION_SIMPLE.each_char do |char|
        # Espace normal -> espace fine insécable
        correct = char
        wrong_space = SPACE + char
        @ortho.gsub! wrong_space, correct
      end
    end
  end
end