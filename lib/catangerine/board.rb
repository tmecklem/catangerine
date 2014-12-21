module Catangerine
  class Board
    include ContainsHexGrid
    attr_reader :state, :robber_location

    def initialize
      @state = :set_up
    end

    def settlement_at(location)
      vertex_at(location).attributes[:settlement]
    end

    def add_settlement(settlement, location)
      vertex = vertex_at(location)
      return false unless vertex.attributes[settlement.object_type].nil?
      return false unless Settlement.adjacent_settlements(vertex).all?(&:nil?)
      set_vertex_object(settlement, location)
      true
    end

    def add_harbor(harbor, location)
      vertex = vertex_at(location)
      return false unless vertex.attributes[harbor.object_type].nil?
      set_vertex_object(harbor, location)
      true
    end

    def road_at(location)
      edge_at(location).object
    end

    def add_road(road, location)
      edge = edge_at(location)
      return false unless edge.object.nil?
      set_edge_object(road, location)
      true
    end

    def move_robber(location)
      @robber_location = location
    end

    def tiles(resource_type = nil)
      tiles = hexes.values.map(&:face).compact
      unless resource_type.nil?
        tiles = tiles.select { |tile| tile.resource_type == resource_type }
      end
      tiles
    end

    def harbors
      hexes.values.map(&:vertices).each_with_object([]) do |vertices, acc|
        acc.concat(vertices.values.map { |vertex| vertex.attributes[:harbor] } )
      end.compact.uniq
    end

    def settlements
      hexes.values.map(&:vertices).each_with_object([]) do |vertices, acc|
        acc.concat(vertices.values.map { |vertex| vertex.attributes[:settlement] } )
      end.compact.uniq
    end
  end
end
