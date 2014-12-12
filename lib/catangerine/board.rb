module Catangerine
  class Board
    include ContainsHexGrid
    attr_reader :state

    def initialize
      @game_grid = GameGrid.new
      @state = :set_up
    end

    def settlement_at(*location)
      vertex_at(*location).attributes[:settlement]
    end

    def add_settlement(settlement, *location)
      vertex = vertex_at(*location)
      return false unless vertex.attributes[settlement.object_type].nil?
      set_vertex_object(settlement, *location)
      true
    end

    def add_harbor(harbor, *location)
      vertex = vertex_at(*location)
      return false unless vertex.attributes[harbor.object_type].nil?
      set_vertex_object(harbor, *location)
      true
    end

    def road_at(*location)
      edge_at(*location).object
    end

    def add_road(road, *location)
      edge = edge_at(*location)
      return false unless edge.object.nil?
      set_edge_object(road, *location)
      true
    end

    def tiles
      @game_grid.to_a.map(&:face).compact
    end

    def harbors
      @game_grid.to_a.map(&:vertices).each_with_object([]) do |vertices, acc|
        acc.concat(vertices.values.map { |vertex| vertex.attributes[:harbor] } )
      end.compact.uniq
    end

    protected

    def game_grid
      @game_grid
    end
  end
end
