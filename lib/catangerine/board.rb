module Catangerine
  class Board
    include ContainsHexGrid
    attr_reader :state, :robber_location

    def initialize
      @state = :set_up
    end

    def settlement_at(location)
      vertex_at(location).settlement
    end

    def harbor_at(location)
      vertex_at(location).harbor
    end

    def road_at(location)
      edge_at(location).object
    end

    def add_settlement(settlement, location)
      vertex = vertex_at(location)
      return false if vertex.settlement
      return false if Settlement.adjacent_settlements(vertex).any?
      set_vertex_object(settlement, location, :settlement)
      true
    end

    def add_harbor(harbor, location)
      return false if harbor_at(location)
      set_vertex_object(harbor, location, :harbor)
      true
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
        acc.concat(vertices.values.map(&:harbor))
      end.compact.uniq
    end

    def settlements
      hexes.values.map(&:vertices).each_with_object([]) do |vertices, acc|
        acc.concat(vertices.values.map(&:settlement))
      end.compact.uniq
    end

    def roads(player = nil)
      roads = hexes.values.map(&:edges).each_with_object([]) do |edges, acc|
        acc.concat(edges.values.map(&:object))
      end.compact.uniq
      roads.select { |road| player.nil? || road.player == player }
    end
  end
end
