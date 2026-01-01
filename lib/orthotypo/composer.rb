module Orthotypo
  class Composer
    SPACE = ' '.freeze
    NBSP = ' '.freeze
    NNBSP = ' '.freeze

    NON_BREAKING_SPACE_BEFORE = [
      ';',
      ':',
      '!',
      '?',
      '”',
      '»',
      '›'
    ].freeze

    NON_BREAKING_SPACE_AFTER = [
      '“',
      '«',
      '‹'
    ].freeze

    def initialize(string)
      @string = string
    end

    def to_s
      unless @ortho
        @ortho = @string.dup
        # Espace normal avant -> espace fine insécable avant
        NON_BREAKING_SPACE_BEFORE.each do |char|
          fix(SPACE + char, NNBSP + char)
        end
        # Espace normal après -> espace fine insécable après
        NON_BREAKING_SPACE_AFTER.each do |char|
          fix(char + SPACE, char + NNBSP)
        end
      end
      @ortho
    end

    protected

    def fix(bad, good)
      @ortho.gsub!(bad, good)
    end
  end
end