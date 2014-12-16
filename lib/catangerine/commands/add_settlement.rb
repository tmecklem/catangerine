module Catangerine
  module Commands
    class AddSettlement < Command
      attr_reader :settlement

      def execute(game_manager)
        @settlement = Catangerine::Settlement.new(@player)
        @success = game_manager.board.add_settlement(@settlement, attributes[:settlement_location])
      end
    end
  end
end
