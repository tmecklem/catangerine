module Catangerine
  module Commands
    class AddRoad
      include Catangerine::Conditions
      attr_reader :success, :player, :road_location, :errors

      CONDITIONS = [
        Or(RoadTouchesSettlement, RoadTouchesRoad, SetupRound)
      ]

      def initialize(player, road_location)
        @player = player
        @road_location = road_location
      end

      def execute(game_manager)
        return @success = false if !validate_command(game_manager)

        road = Catangerine::Road.new(@player)
        @success = game_manager.board.add_road(road, @road_location)
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
