module Orthotypo
  class Composer::Fr < Composer

    protected

    def chars_with_space_before
      [
        '%'
      ]
    end

    def chars_with_space_after
      [
        ',',
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

    def chars_with_no_space_before
      [
        '.'
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
        '‹›',
        '""',
        "''",
        "()",
        "{}",
        "[]"
      ]
    end
  end
end