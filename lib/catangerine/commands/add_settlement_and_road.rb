module Catangerine
  module Commands
    class AddSettlementAndRoad < Command
      include Catangerine::Conditions

      CONDITIONS = [
        SettlementAndRoadTouching
      ]

      def execute(game_manager)
        return @success = false if !validate_command(game_manager)

        @add_settlement = AddSettlement.new(player, settlement_location: attributes[:settlement_location])
        @add_road = AddRoad.new(player, road_location: attributes[:road_location])

        @success = @add_settlement.execute(game_manager) && @add_road.execute(game_manager)
        resource_me(game_manager) if @success && game_manager.round == 2
        @success
      end

      def validate_command(game_manager)
        @errors = CONDITIONS.map do |condition|
          condition.call(self, game_manager)
        end.select { |result| !result.first }
        @errors.empty?
      end

      def resource_me(game_manager)
        @add_settlement.settlement.touching_tiles.each do |tile|
          @player.resource_cards[tile.resource_type] ||= 0
          @player.resource_cards[tile.resource_type] += 1
        end
      end
    end
  end
end
