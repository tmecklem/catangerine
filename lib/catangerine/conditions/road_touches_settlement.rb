module Catangerine
  module Conditions
    RoadTouchesSettlement = ->(command, game_manager) {
      player = command.player
      settlements = game_manager.board.settlements
      connected = settlements.any? do |settlement|
        break false unless settlement.player == player
        protruding_edge_locations = settlement.position.protruding_edges.map do |edge|
          edge.location
        end
        protruding_edge_locations.include?(command.road_location)
      end
      [connected, "The road must be touching a settlement"]
    }
  end
end
