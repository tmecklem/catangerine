module Catangerine
  class Settlement
    attr_reader :player
    attr_accessor :position

    def initialize(player)
      @player = player
    end

    def object_type
      self.class.name.split("::").last.downcase.to_sym
    end

    def touching_tiles
      position.touching_hexes.map(&:face)
    end
  end
end
