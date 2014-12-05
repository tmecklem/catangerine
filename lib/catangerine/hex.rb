module Catangerine
  class Hex
    attr_accessor :q, :r, :tile

    def initialize(board, q, r, tile = nil)
      @board = board
      @q = q
      @r = r
      @tile = tile
    end

    NEIGHBORS = [
      [ 1, 0], [ 1, -1], [0, -1],
      [-1, 0], [-1,  1], [0,  1]
    ]

    def neighbor(direction)
      d = NEIGHBORS[direction]
      @board.hex_at(q + d[0], r + d[1])
    end
  end
end
