module Catangerine
  class Road
    attr_reader :player
    attr_accessor :position

    def initialize(player)
      @player = player
    end

    def connected_segments
      edge = position
      edge.connections.map { |connection|
        road = connection[:edge].road
        belongs_to_player = road && road.player == player
        road if belongs_to_player
      }.compact
    end

    def to_s
      "Road - #{position}"
    end
  end
end
