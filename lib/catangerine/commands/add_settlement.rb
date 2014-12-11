module Catangerine
  module Commands
    class AddSettlement
      attr_reader :success

      def initialize(player, *coords)
        @player = player
        @coords = coords
      end

      def execute(game_manager)
        settlement = Catangerine::Settlement.new(@player)
        @success = game_manager.board.add_vertex_object(*@coords, settlement)
      end
    end
  end
end
