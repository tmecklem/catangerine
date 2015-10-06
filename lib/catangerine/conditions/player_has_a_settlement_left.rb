module Catangerine
  module Conditions
    PlayerHasASettlementLeft = lambda { |command, game_manager|
      settlements_placed_count = game_manager.board.settlements(command.player).size
      total_settlement_count = game_manager.number_of_settlements
      ConditionResult.new(met: settlements_placed_count < total_settlement_count, detail: 'player must have a settlement left to play')
    }
  end
end
