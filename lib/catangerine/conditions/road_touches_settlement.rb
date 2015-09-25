module Catangerine
  module Conditions
    RoadTouchesSettlement = lambda { |command, game_manager|
      player = command.player
      road_location = command.attributes[:road_location]
      settlements = game_manager.board.settlements
      connected = settlements.any? do |settlement|
        break false unless settlement.player == player
        protruding_edge_locations = settlement.position.protruding_edges.map(&:location)
        protruding_edge_locations.include?(road_location)
      end
      ConditionResult.new(met: connected, detail: "The road must be touching a settlement")
    }
  end
end
