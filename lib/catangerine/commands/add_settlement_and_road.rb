module Catangerine
  module Commands
    class AddSettlementAndRoad
      attr_reader :success

      def initialize(player, q0, r0, v, q1, r1, e)
        @vertex_position = [q0, r0, v]
        @player = player
        @add_settlement = AddSettlement.new(player, q0, r0, v)
        @add_road = AddRoad.new(player, q1, r1, e)
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
