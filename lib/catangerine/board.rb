module Catangerine
  class Board
    def initialize
      @game_grid = GameGrid.new
    end

    def hex_at(q, r)
      @game_grid[q][r] ||= Hex.new(self, q, r)
    end

    def tiles
      @game_grid.to_a.map(&:face).compact
    end

    def harbors
      @game_grid.to_a.map(&:vertices).each_with_object([]) do |vertices, acc|
        acc.concat(vertices.values)
      end.compact.uniq
    end
  end
end
