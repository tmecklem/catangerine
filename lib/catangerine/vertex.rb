module Catangerine
  class Vertex
    attr_reader :direction, :attributes

    def initialize(hex, direction)
      @hex = hex
      @direction = direction
      @attributes = {}
    end

    def touching_hexes
      hex_touch_map = {
        t: [@hex, @hex.neighbor(:ne), @hex.neighbor(:nw)],
        b: [@hex.neighbor(:sw), @hex.neighbor(:se), @hex]
      }
      hex_touch_map[@direction]
    end

    def adjacent_vertices
      vertex_adjacency_map = {
        t: [@hex.neighbor(:nw).vertices[:b], @hex.neighbor(:ne).vertices[:b], @hex.neighbor(:nw).neighbor(:ne).vertices[:b]],
        b: [@hex.neighbor(:sw).vertices[:t], @hex.neighbor(:se).vertices[:t], @hex.neighbor(:sw).neighbor(:se).vertices[:t]]
      }
      vertex_adjacency_map[direction]
    end
  end
end
