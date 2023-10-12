module Orthotypo
  class Parser
    attr_reader :string, :ortho

    SPACE = ' '.freeze
    NNBSP = ' '.freeze
    DOUBLE_SIGNS = ';:!?'.freeze
    SIMPLE_SIGNS = ',.'.freeze

    def initialize(string)
      @string = string
      @ortho = string.dup
      parse
    end

    protected

    def parse
      DOUBLE_SIGNS.each_char do |sign|
        # Espace normal -> espace fine insécable
        correct = NNBSP + sign
        wrong_space = SPACE + sign
        @ortho.gsub! wrong_space, correct
        # Pas d'espace -> espace fine insécable
        correct = "\\1" + NNBSP + sign
        no_space = /(\w)[#{sign}]/
        @ortho.gsub! no_space, correct
      end
    end
  end
end