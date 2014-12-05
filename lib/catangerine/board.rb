module Catangerine
  class Board
    def initialize
      @game_grid = GameGrid.new
    end

    def hex_at(q, r)
      @game_grid[q][r] ||= Hex.new(self, q, r)
    end

    def tiles
      @game_grid.to_a.map do |hex|
        hex.tile
      end.compact
    end
  end
end
