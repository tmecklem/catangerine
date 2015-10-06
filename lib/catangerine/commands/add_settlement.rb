module Catangerine
  module Commands
    class AddSettlement < Command
      attr_reader :settlement

      protected

      def command_conditions
        Or.call(
          AndCondition.call(HasSettlementCards, SettlementTouchesRoad, PlayerHasASettlementLeft),
          SetupRound
        )
      end

      def execute_after_validation(game_manager)
        @settlement = Catangerine::Settlement.new(@player)
        @success = game_manager.board.add_settlement(@settlement, attributes[:settlement_location])
      end
    end
  end
end
