module Catangerine
  module Commands
    class AddSettlementAndRoad
      attr_reader :success

      def initialize(player, q0, r0, v, q1, r1, e, add_resources = false)
        @q = q0
        @r = r0
        @v = v
        @player = player
        @add_settlement = AddSettlement.new(player, q0, r0, v)
        @add_road = AddRoad.new(player, q1, r1, e)
        @add_resources = add_resources
      end

      def execute(game_manager)
        @success = @add_settlement.execute(game_manager) && @add_road.execute(game_manager)
        if @success
          resource_me(game_manager)
        end
        @success
      end

      def resource_me(game_manager)
        vertex = game_manager.board.hex_at(@q, @r).vertices[@v]
        vertex.touching_hexes.each do |hex|
          @player.resource_cards[hex.face.resource_type] ||= 0
          @player.resource_cards[hex.face.resource_type] += 1
        end
      end
    end
  end
end
