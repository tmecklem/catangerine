module Catangerine
  class Board
    attr_reader :tile_layout

    DEFAULT_OPTIONS = {
      player_count: 3
    }

    STANDARD_TILE_COUNTS = {
      hills: 3,
      pasture: 4,
      mountains: 3,
      fields: 4,
      forest: 4,
      desert: 1
    }

    def initialize(opts = {})
      options = DEFAULT_OPTIONS.merge(opts)
    end

    def generate
      @tile_layout = []
      STANDARD_TILE_COUNTS.each do |type, num|
        num.times do |i|
          @tile_layout << type
        end
      end
      @tile_layout.shuffle!
    end
  end
end
