module Catangerine
  class Road
    attr_reader :player
    attr_accessor :position

    def initialize(player)
      @player = player
    end

    def connected_roads
      edge = self.position
      edge.continuing_edges.map do |continuing_edge|
        road = continuing_edge.object
        if road && road.player == player
          road
        else
          nil
        end
      end.compact
    end
  end
end
