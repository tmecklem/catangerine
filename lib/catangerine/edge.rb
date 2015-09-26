module Catangerine
  class Edge
    attr_accessor :object
    attr_reader :hex, :direction

    def initialize(hex, direction)
      @hex = hex
      @direction = direction
    end

    def location
      Location.new(hex.location.q, hex.location.r, direction)
    end

    def to_s
      location.to_s
    end

    def road
      object
    end

    def connections
      send("#{direction}_connections")
    end

    def nw_connections
      [
        { edge: @hex.ne_neighbor.w_edge, vertex: @hex.top_vertex },
        { edge: @hex.ne_neighbor.sw_edge, vertex: @hex.top_vertex },
        { edge: @hex.w_edge, vertex: @hex.nw_neighbor.bottom_vertex },
        { edge: @hex.nw_neighbor.sw_edge, vertex: @hex.nw_neighbor.bottom_vertex }
      ]
    end

    def w_connections
      [
        { edge: @hex.nw_edge, vertex: @hex.nw_neighbor.bottom_vertex },
        { edge: @hex.sw_edge, vertex: @hex.sw_neighbor.top_vertex },
        { edge: @hex.nw_neighbor.sw_edge, vertex:  @hex.nw_neighbor.bottom_vertex },
        { edge: @hex.sw_neighbor.nw_edge, vertex: @hex.sw_neighbor.top_vertex }
      ]
    end

    def sw_connections
      [
        { edge: @hex.w_edge, vertex: @hex.sw_neighbor.top_vertex },
        { edge: @hex.sw_neighbor.nw_edge, vertex: @hex.sw_neighbor.top_vertex },
        { edge: @hex.se_neighbor.nw_edge, vertex: @hex.bottom_vertex },
        { edge: @hex.se_neighbor.w_edge, vertex: @hex.bottom_vertex }
      ]
    end
  end
end
