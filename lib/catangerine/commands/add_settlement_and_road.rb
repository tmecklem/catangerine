module Catangerine
  module Commands
    class AddSettlementAndRoad < Command
      protected

      def command_conditions
        SettlementAndRoadTouching
      end

      def execute_after_validation(game_manager)
        @add_settlement = AddSettlement.new(player, settlement_location: attributes[:settlement_location])
        @add_road = AddRoad.new(player, road_location: attributes[:road_location])

        @success = @add_settlement.execute(game_manager) && @add_road.execute(game_manager)
        resource_me(game_manager) if @success && game_manager.round == 2
        @success
      end

      def resource_me(_game_manager)
        @add_settlement.settlement.touching_tiles.each do |tile|
          @player.acquire_cards(tile.resource_type, 1) if tile.resource_type
        end
      end
    end
  end
end
