module Orthotypo
  class Parser
    attr_reader :string, :ortho

    SPACE = ' '.freeze
    NBSP = ' '.freeze
    NNBSP = ' '.freeze

    CHARS_WITH_SPACE_BEFORE = [
      '%'
    ].freeze
    CHARS_WITH_SPACE_AFTER = [
      ',',
      '.',
      '...',
      '…'
    ].freeze
    CHARS_WITH_SPACE_AROUND = [
      ';',
      ':',
      '!',
      '?'
    ].freeze
    CHARS_WITH_NOSPACE_AROUND = [
      "'",
      '’',
      'ʼ'
    ].freeze
    PAIRS_WITH_SPACE_AROUND = [
      '«»'
    ].freeze
    PAIRS_WITH_NO_SPACE_AROUND = [
      '“”',
      '‘’',
      '‹›',
      '""',
      "''",
      "()",
      "{}",
      "[]"
    ].freeze

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

    def determine_locale
      # TODO (avec I18n si présent)
    end

    def determine_html
      # TODO
    end

    def parse
      # Chars
      chars_with_space_before
      chars_with_space_after
      chars_with_space_around
      chars_with_no_space_around
      # Pairs
      pairs_with_space_around
      pairs_with_no_space_around
    end

    def chars_with_space_before
      CHARS_WITH_SPACE_BEFORE.each do |char|
        # Espace normal avant -> espace fine insécable avant
        fix(SPACE + '%', NNBSP + '%')
        # Pas d'espace avant -> espace fine insécable avant
        fix(/([[:alnum:]])%/, "\\1" + NNBSP + '%')
      end
    end

    def chars_with_space_after
      CHARS_WITH_SPACE_AFTER.each do |char|
        # Espace avant -> pas d'espace avant 
        fix(SPACE + char, char)
        # Pas d'espace après -> espace après
        fix(/[#{char}]([[:alnum:]])/, char + SPACE + "\\1")
      end
    end

    def chars_with_space_around
      CHARS_WITH_SPACE_AROUND.each do |char|
        # Espace normal avant -> espace fine insécable avant
        fix(SPACE + char, NNBSP + char)
        # Pas d'espace avant -> espace fine insécable avant
        fix(/([[:alnum:]])[#{char}]/, "\\1" + NNBSP + char)
      end
    end

    def chars_with_no_space_around
      CHARS_WITH_NOSPACE_AROUND.each do |char|
        # Espace avant -> pas d'espace avant 
        fix(SPACE + char, char)
        # Espace après -> pas d'espace après 
        fix(char + SPACE, char)
      end
    end

    def pairs_with_space_around
      PAIRS_WITH_SPACE_AROUND.each do |marks|
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

    def pairs_with_no_space_around
      PAIRS_WITH_NO_SPACE_AROUND.each do |marks|
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