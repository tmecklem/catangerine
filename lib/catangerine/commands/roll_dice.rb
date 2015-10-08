module Catangerine
  module Commands
    class Dice < Command
      attr_reader :die1, :die2

      def dice_value
        die1 + die2
      end

      protected

      def command_conditions
        []
      end

      def execute_after_validation(game_manager)
        @die1 = rand(1..6)
        @die2 = rand(1..6)
        grant_resources(game_manager)
      end

      def grant_resources(game_manager)
        matching_tiles = game_manager.board.tiles_with_chit(dice_value)
        matching_tiles.each do |tile|
          tile.touching_settlements.each do |settlement|
            settlement.player.acquire_cards(tile.resource_type, 1)
          end
        end
      end
    end
  end
end
