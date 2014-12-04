module Catangerine
  class Hex
    attr_accessor :q, :r

    def initialize(q, r)
      @q = q
      @r = r
    end

    NEIGHBORS = [
      Hex.new(1, 0),
      Hex.new(1, -1),
      Hex.new(0, -1),
      Hex.new(-1, 0),
      Hex.new(-1, 1),
      Hex.new(0, 1)
    ]

    def to_cube
      Cube.new(q, -q-r, r)
    end

    def neighbor(direction)
      d = NEIGHBORS[direction]
      Hex.new(q + d.q, r + d.r)
    end

    def to_hex
      self
    end
  end
end
