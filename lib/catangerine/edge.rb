module Catangerine
  class Edge
    attr_accessor :object
    attr_reader :hex, :direction

    def initialize(hex, direction)
      @hex = hex
      @direction = direction
    end

    def connections
      @connections_map ||= {
        nw: [
          { edge: @hex.neighbor(:ne).edges[:w], vertex: @hex.vertices[:t] },
          { edge: @hex.neighbor(:ne).edges[:sw], vertex: @hex.vertices[:t] },
          { edge: @hex.edges[:w], vertex: @hex.neighbor(:nw).vertices[:b] },
          { edge: @hex.neighbor(:nw).edges[:sw], vertex: @hex.neighbor(:nw).vertices[:b] }
        ],
        w: [
          { edge: @hex.edges[:nw], vertex: @hex.neighbor(:nw).vertices[:b] },
          { edge: @hex.edges[:sw], vertex: @hex.neighbor(:sw).vertices[:t] },
          { edge: @hex.neighbor(:nw).edges[:sw], vertex:  @hex.neighbor(:nw).vertices[:b] },
          { edge: @hex.neighbor(:sw).edges[:nw], vertex: @hex.neighbor(:sw).vertices[:t] }
        ],
        sw: [
          { edge: @hex.edges[:w], vertex: @hex.neighbor(:sw).vertices[:t] },
          { edge: @hex.neighbor(:sw).edges[:nw], vertex: @hex.neighbor(:sw).vertices[:t] },
          { edge: @hex.neighbor(:se).edges[:nw], vertex: @hex.vertices[:b] },
          { edge: @hex.neighbor(:se).edges[:w], vertex: @hex.vertices[:b] }
        ]
      }
      @connections_map[direction]
    end

    def location
      Location.new(hex.location.q, hex.location.r, direction)
    end

    def to_s
      location
    end

    def road
      object
    end
  end
end
