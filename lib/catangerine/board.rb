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

    def vertex_at(q, r, v)
      hex_at(q,r).vertices[v.to_sym]
    end

    def add_vertex_object(q, r, v, obj)
      vertex = vertex_at(q, r, v)
      return false unless vertex.object.nil?
      vertex.object = obj
      true
    end

    def edge_at(q, r, e)
      hex_at(q,r).edges[e.to_sym]
    end

    def add_edge_object(q, r, e, obj)
      edge_at(q, r, e).object = obj
    end

    def tiles
      @game_grid.to_a.map(&:face).compact
    end

    def harbors
      @game_grid.to_a.map(&:vertices).each_with_object([]) do |vertices, acc|
        acc.concat(vertices.values.map(&:object))
      end.compact.uniq
    end
  end
end
