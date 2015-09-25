module Catangerine
  module Conditions
    RoadTouchesRoad = lambda { |command, game_manager|
      player = command.player
      road_location = command.attributes[:road_location]
      edge = game_manager.board
             .hex_at(road_location)
             .edges[road_location.direction]

      connected = edge.connections.map { |c| c[:edge] }.any? do |continuing_edge|
        road = game_manager.board.road_at(
          continuing_edge.location
        )
        road && road.player == player
      end
      ConditionResult.new(met: connected, detail: "The road must be touching a road")
    }
  end
end
