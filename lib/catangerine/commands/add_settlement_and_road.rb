module Catangerine
  module Commands
    class AddSettlementAndRoad
      attr_reader :success

      def initialize(player, settlement_location, road_location)
        @settlement_location = settlement_location
        @player = player
        @add_settlement = AddSettlement.new(player, settlement_location)
        @add_road = AddRoad.new(player, road_location)
      end

      def execute(game_manager)
        @success = @add_settlement.execute(game_manager) && @add_road.execute(game_manager)
        resource_me(game_manager) if @success && game_manager.round == 2
        @success
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
