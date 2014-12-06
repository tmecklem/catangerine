module Catangerine
  class Board
    attr_reader :state

    def initialize
      @game_grid = GameGrid.new
      @state = :set_up
    end

    def hex_at(q, r)
      @game_grid[q][r] ||= Hex.new(self, q, r)
    end

    def add_vertex_object(q, r, v, obj)
      hex_at(q,r).vertices[v] = obj
    end

    def add_edge_object(q, r, e, obj)
      hex_at(q,r).edges[e] = obj
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
