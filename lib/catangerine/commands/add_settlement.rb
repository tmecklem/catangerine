module Catangerine
  module Commands
    class AddSettlement
      attr_reader :success

      def initialize(player, q, r, v)
        @player = player
        @q = q.to_i
        @r = r.to_i
        @v = v.to_sym
      end

      def execute(game_manager)
        settlement = Catangerine::Settlement.new(@player)
        game_manager.board.add_vertex_object(@q,@r,@v, settlement)
        @success = true
      end
    end
  end
end
