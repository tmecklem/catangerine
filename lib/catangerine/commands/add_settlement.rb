module Catangerine
  module Commands
    class AddSettlement < Command
      attr_reader :settlement

      CONDITIONS = [
        CorrectPlayerTurn
      ]

      def execute(game_manager)
        return @success = false if !validate_command(game_manager)

        @settlement = Catangerine::Settlement.new(@player)
        @success = game_manager.board.add_settlement(@settlement, attributes[:settlement_location])
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
