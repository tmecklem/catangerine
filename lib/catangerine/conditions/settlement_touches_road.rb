module Catangerine
  module Conditions
    SettlementTouchesRoad = lambda { |command, game_manager|
      player = command.player
      settlement_location = command.attributes[:settlement_location]
      protruding_edges = game_manager.board.vertex_at(settlement_location).protruding_edges
      roads = game_manager.board.roads(player)
      condition_met = roads.any? { |road|
        protruding_edges.include?(road.position)
      }
      ConditionResult.new(met: condition_met, detail: "The settlement must be touching a road")
    }
  end
end
