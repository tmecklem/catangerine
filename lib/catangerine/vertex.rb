module Catangerine
  class Vertex
    attr_reader :direction, :attributes

    def initialize(hex, direction)
      @hex = hex
      @direction = direction
      @attributes = {
        harbor: nil,
        settlement: nil
      }
    end

    def location
      Location.new(@hex.location.q, @hex.location.r, direction)
    end

    def touching_hexes
      hex_touch_map = {
        t: [@hex, @hex.neighbor(:ne), @hex.neighbor(:nw)],
        b: [@hex.neighbor(:sw), @hex.neighbor(:se), @hex]
      }
      hex_touch_map[@direction]
    end

    def adjacent_vertices
      @vertex_adjacency_map ||= {
        t: top_adjacencies,
        b: bottom_adjacencies
      }
      @vertex_adjacency_map[direction]
    end

    def protruding_edges
      @protruding_edges_map ||= {
        t: [
          @hex.nw_edge,
          @hex.ne_neighbor.sw_edge,
          @hex.ne_neighbor.w_edge
        ],
        b: [
          @hex.sw_edge,
          @hex.se_neighbor.nw_edge,
          @hex.se_neighbor.w_edge
        ]
      }
      @protruding_edges_map[direction]
    end

    def to_s
      ""
    end

    def method_missing(method_sym, *arguments, &block)
      return @attributes[method_sym] if @attributes.key?(method_sym)
      super
    end

    def respond_to?(method_sym, include_private = false)
      return true if @attributes.key?(method_sym)
      super
    end

    private

    def top_adjacencies
      [
        @hex.nw_neighbor.bottom_vertex,
        @hex.ne_neighbor.bottom_vertex,
        @hex.nw_neighbor.ne_neighbor.bottom_vertex
      ]
    end

    def bottom_adjacencies
      [
        @hex.sw_neighbor.top_vertex,
        @hex.se_neighbor.top_vertex,
        @hex.sw_neighbor.se_neighbor.top_vertex
      ]
    end
  end
end
