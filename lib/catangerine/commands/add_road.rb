module Catangerine
  module Commands
    class AddRoad < Command
      protected

      def command_conditions
        Or.call(RoadTouchesSettlement, RoadTouchesRoad, SetupRound)
      end

      def execute_after_validation(game_manager)
        road = Catangerine::Road.new(@player)
        @success = game_manager.board.add_road(road, attributes[:road_location])
      end
    end
  end
end
