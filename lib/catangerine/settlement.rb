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
      position.touching_hexes.map(&:face).compact
    end

    def self.adjacent_settlements(vertex)
      vertex.adjacent_vertices.map { |vertex| vertex.attributes[:settlement] }.compact
    end
  end
end
