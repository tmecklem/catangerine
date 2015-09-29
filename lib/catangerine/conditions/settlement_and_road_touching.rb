module Catangerine
  module Conditions
    SettlementAndRoadTouching = lambda { |command, game_manager|
      road_location = command.attributes[:road_location]
      settlement_location = command.attributes[:settlement_location]
      settlement_vertex = game_manager.board
                          .vertex_at(settlement_location)
      protruding_edge_locations = settlement_vertex.protruding_edges.map do |edge|
        Location.new(edge.hex.location.q, edge.hex.location.r, edge.direction)
      end
      connected = protruding_edge_locations.include?(road_location)
      ConditionResult.new(met: connected, detail: "The settlement and road must be touching")
    }
  end
end
