module Catangerine
  class Vertex
    attr_reader :direction
    attr_accessor :object

    def initialize(hex, direction)
      @hex = hex
      @direction = direction
    end

    def touching_hexes
      @vertex_touches = {
        t: [@hex, @hex.neighbor(:ne), @hex.neighbor(:nw)],
        b: [@hex.neighbor(:sw), @hex.neighbor(:se), @hex]
      }
      @vertex_touches[@direction]
    end
  end
end
