module Catangerine
  module Commands
    class AddRoad
      attr_accessor :success

      def initialize(player, q, r, e)
        @player = player
        @q = q.to_i
        @r = r.to_i
        @e = e.to_sym
      end

      def execute(game_manager)
        road = Catangerine::Road.new(@player)
        game_manager.board.add_edge_object(@q,@r,@e, road)
        @success = true
      end
    end
  end
end
