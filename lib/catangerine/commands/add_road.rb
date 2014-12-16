module Catangerine
  module Commands
    class AddRoad < Command
      CONDITIONS = [
        CorrectPlayerTurn,
        Or(RoadTouchesSettlement, RoadTouchesRoad, SetupRound)
      ]

      def execute(game_manager)
        return @success = false if !validate_command(game_manager)

        road = Catangerine::Road.new(@player)
        @success = game_manager.board.add_road(road, attributes[:road_location])
      end

      def validate_command(game_manager)
        @errors = CONDITIONS.map do |condition|
          condition.call(self, game_manager)
        end.select { |result| !result.first }
        @errors.empty?
      end
    end
  end
end
