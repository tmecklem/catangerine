module Catangerine
  class Edge
    attr_accessor :object
    attr_reader :hex, :direction

    def initialize(hex, direction)
      @hex = hex
      @direction = direction
    end

    def continuing_edges
      @continuing_edges_map ||= {
        nw: [
          @hex.neighbor(:ne).edges[:w],
          @hex.neighbor(:ne).edges[:sw],
          @hex.edges[:w],
          @hex.neighbor(:nw).edges[:sw]
        ],
        w: [
          @hex.edges[:nw],
          @hex.edges[:sw],
          @hex.neighbor(:nw).edges[:sw],
          @hex.neighbor(:sw).edges[:nw]
        ],
        sw: [
          @hex.edges[:w],
          @hex.neighbor(:sw).edges[:nw],
          @hex.neighbor(:se).edges[:nw],
          @hex.neighbor(:se).edges[:w]
        ]
      }
      @continuing_edges_map[direction]
    end

    def location
      Location.new(hex.location.q, hex.location.r, direction)
    end

    def to_s
      ""
    end
  end
end
