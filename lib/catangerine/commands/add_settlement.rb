module Catangerine
  module Commands
    class AddSettlement
      attr_reader :success, :settlement

      def initialize(player, location)
        @player = player
        @location = location
      end

      def execute(game_manager)
        @settlement = Catangerine::Settlement.new(@player)
        @success = game_manager.board.add_settlement(@settlement, @location)
      end
    end
  end
end
