module Catangerine
  class Settlement
    attr_reader :player
    attr_accessor :position

    def initialize(player)
      @player = player
    end

    def touching_tiles
      position.touching_hexes.map(&:face).compact
    end

    def self.adjacent_settlements(vertex)
      vertex.adjacent_vertices.map(&:settlement).compact
    end

    def touching_roads
      position.position.protruding_edges.map(&:road).compact
    end
  end
end
