module Catangerine
  class Board
    include ContainsHexGrid
    attr_reader :state, :robber_location

    def initialize
      @state = :set_up
    end

    def observers
      @observers ||= []
    end

    def add_observer(observer)
      observers << observer
    end

    def publish_event(event_name, *arguments)
      arguments.insert(0, self)
      observers.each do |observer|
        observer.send(event_name, *arguments) if observer.respond_to?(event_name)
      end
    end

    def settlement_at(location)
      vertex_at(location).settlement
    end

    def harbor_at(location)
      vertex_at(location).harbor
    end

    def road_at(location)
      edge_at(location).road
    end

    def add_settlement(settlement, location)
      vertex = vertex_at(location)
      return false if vertex.settlement
      return false if Settlement.adjacent_settlements(vertex).any?
      set_vertex_object(settlement, location, :settlement)
      publish_event(:settlement_added, settlement, location)
      true
    end

    def add_harbor(harbor, location)
      return false if harbor_at(location)
      set_vertex_object(harbor, location, :harbor)
      publish_event(:harbor_added, harbor, location)
      true
    end

    def add_road(road, location)
      edge = edge_at(location)
      return false if edge.road
      set_edge_object(road, location)
      publish_event(:road_added, road, location)
      true
    end

    def move_robber(location)
      @robber_location = location
      publish_event(:robber_moved, location)
    end

    def tiles(terrain = nil)
      tiles = hexes.values.map(&:face).compact
      unless terrain.nil?
        tiles = tiles.select { |tile| tile.terrain == terrain }
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
        acc.concat(edges.values.map(&:road))
      end.compact.uniq
      roads.select { |road| player.nil? || road.player == player }
    end
  end
end
