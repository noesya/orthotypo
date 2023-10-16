module Orthotypo
  class Composer::En < Composer

    def chars_with_space_after
      [
        ',',
        '.',
        '...',
        '…',
        ';',
        ':',
        '!',
        '?'
      ]
    end

  end
end