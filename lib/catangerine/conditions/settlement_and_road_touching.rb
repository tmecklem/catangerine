module Catangerine
  module Conditions
    SettlementAndRoadTouching = ->(command, game_manager) {
      settlement_vertex = game_manager.board.
        hex_at(command.settlement_location).
        vertices[command.settlement_location.direction]
      protruding_edge_locations = settlement_vertex.protruding_edges.map do |edge|
        Location.new(edge.hex.location.q, edge.hex.location.r, edge.direction)
      end
      connected = protruding_edge_locations.include?(command.road_location)
      [connected, "The settlement and road must be touching"]
    }
  end
end
