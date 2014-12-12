module Catangerine
  class Settlement
    attr_reader :player
    attr_accessor :position

    def initialize(player)
      @player = player
    end

    def touching_tiles
      position.touching_hexes.map(&:face)
    end
  end
end
