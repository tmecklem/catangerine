module Catangerine
  module ContainsHexGrid
    def hex_at(location)
      hexes[location.without_direction] ||= Hex.new(self, location.without_direction)
    end

    def edge_at(location)
      hex_at(location).edges[location.direction]
    end

    def vertex_at(location)
      hex_at(location).vertices[location.direction]
    end

    protected

    def set_vertex_object(object, location, object_type)
      vertex = vertex_at(location)
      vertex.attributes[object_type] = object
      object.position = vertex
    end

    def set_edge_object(object, location)
      edge = edge_at(location)
      edge.object = object
      object.position = edge
    end

    def hexes
      @hexes ||= {}
    end
  end
end
