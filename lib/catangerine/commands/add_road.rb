module Catangerine
  module Commands
    class AddRoad
      attr_accessor :success

      def initialize(player, *coords)
        @player = player
        @coords = coords
      end

      def execute(game_manager)
        road = Catangerine::Road.new(@player)
        @success = game_manager.board.add_road(road, *@coords)
      end
    end
  end
end
