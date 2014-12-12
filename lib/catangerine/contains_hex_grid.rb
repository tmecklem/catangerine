module Catangerine
  module ContainsHexGrid
    def hex_at(q, r)
      game_grid[q][r] ||= Hex.new(self, q, r)
    end

    protected

    def vertex_at(q, r, v)
      hex_at(q,r).vertices[v.to_sym]
    end

    def set_vertex_object(object, *location)
      vertex = vertex_at(*location)
      vertex.attributes[object.object_type] = object
      object.position = vertex
    end

    def edge_at(q, r, e)
      hex_at(q,r).edges[e.to_sym]
    end

    def set_edge_object(obj, *location)
      edge_at(*location).object = obj
    end

    def game_grid
      raise NotImplementedError, "#{self.class.name} does not implement #{__method__}"
    end
  end
end
