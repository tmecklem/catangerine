module Catangerine
  module Conditions
    CorrectPlayerTurn = lambda { |command, game_manager|
      [command.player == game_manager.current_player, "Must be correct player's turn"]
    }
  end
end
