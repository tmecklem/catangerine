module Catangerine
  module Conditions
    CorrectPlayerTurn = lambda { |command, game_manager|
      ConditionResult.new(met: command.player == game_manager.current_player, detail: "Must be correct player's turn")
    }
  end
end
