module Catangerine
  module Commands
    class AddRoad
      attr_accessor :success

      def initialize(player, location)
        @player = player
        @location = location
      end

      def execute(game_manager)
        road = Catangerine::Road.new(@player)
        @success = game_manager.board.add_road(road, @location)
      end
    end
  end
end
