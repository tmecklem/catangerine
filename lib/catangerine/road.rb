module Catangerine
  class Road
    attr_reader :player
    attr_accessor :position

    def initialize(player)
      @player = player
    end

    def connected_segments
      edge.connections.map { |connection|
        { road: connection[:edge].road, vertex: connection[:vertex] } if belongs_to_player(connection) && unblocked(connection)
      }.compact
    end

    def to_s
      edge.to_s
    end

    private

    def edge
      position
    end

    def unblocked(connection)
      connection[:vertex].settlement.nil? || connection[:vertex].settlement.player == player
    end

    def belongs_to_player(connection)
      road = connection[:edge].road
      road && road.player == player
    end
  end
end
