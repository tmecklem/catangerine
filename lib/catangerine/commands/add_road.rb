module Catangerine
  module Commands
    class AddRoad < Command
      protected

      def command_conditions
        AndCondition.call(
          Or.call(RoadTouchesSettlement, RoadTouchesRoad, SetupRound),
          HasRoadCards
        )
      end

      def execute_after_validation(game_manager)
        road = Catangerine::Road.new(@player)
        @success = game_manager.board.add_road(road, attributes[:road_location])
        return @success unless @success
        @player.return_cards(:brick, 1)
        @player.return_cards(:lumber, 1)
        @success
      end
    end
  end
end
