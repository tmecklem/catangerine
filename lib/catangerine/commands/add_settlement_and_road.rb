module Catangerine
  module Commands
    class AddSettlementAndRoad
      attr_reader :success

      def initialize(player, settlement_location, road_location)
        @settlement_location = settlement_location
        @road_location = road_location
        @player = player
        @add_settlement = AddSettlement.new(player, settlement_location)
        @add_road = AddRoad.new(player, road_location)
      end

      def execute(game_manager)
        return @success = false if !validate_command(game_manager)

        @success = @add_settlement.execute(game_manager) && @add_road.execute(game_manager)
        resource_me(game_manager) if @success && game_manager.round == 2
        @success
      end

      def validate_command(game_manager)
        settlement_vertex = game_manager.board.
          hex_at(@settlement_location).
          vertices[@settlement_location.direction]
        protruding_edge_locations = settlement_vertex.protruding_edges.map do |edge|
          Location.new(edge.hex.location.q, edge.hex.location.r, edge.direction)
        end
        protruding_edge_locations.include?(@road_location)
      end

      def resource_me(game_manager)
        @add_settlement.settlement.touching_tiles.each do |tile|
          @player.resource_cards[tile.resource_type] ||= 0
          @player.resource_cards[tile.resource_type] += 1
        end
      end
    end
  end
end
