module Catangerine
  module ContainsHexGrid
    def hex_at(location)
      game_grid[location.q][location.r] ||= Hex.new(self, location)
    end

    protected

    def vertex_at(location)
      hex_at(location).vertices[location.direction]
    end

    def set_vertex_object(object, location)
      vertex = vertex_at(location)
      vertex.attributes[object.object_type] = object
      object.position = vertex
    end

    def edge_at(location)
      hex_at(location).edges[location.direction]
    end

    def set_edge_object(obj, location)
      edge_at(location).object = obj
    end

    def game_grid
      raise NotImplementedError, "#{self.class.name} does not implement #{__method__}"
    end
  end
end
