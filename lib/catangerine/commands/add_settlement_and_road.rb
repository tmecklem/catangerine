module Catangerine
  module Commands
    class AddSettlementAndRoad
      attr_reader :success

      def initialize(player, q0, r0, v, q1, r1, e)
        @add_settlement = AddSettlement.new(player, q0, r0, v)
        @add_road = AddRoad.new(player, q1, r1, e)
      end

      def execute(game_manager)
        @success = @add_settlement.execute(game_manager) && @add_road.execute(game_manager)
      end
    end
  end
end
