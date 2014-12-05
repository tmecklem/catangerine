module Catangerine
  class Hex
    attr_accessor :q, :r, :face, :edges, :vertices

    def initialize(board, q, r, face = nil)
      @board = board
      @q = q
      @r = r
      @face = face
      @edges = {}
      @vertices = {}
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
