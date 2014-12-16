module Catangerine
  module Conditions
    CorrectPlayerTurn = ->(command, game_manager) {
      [command.player == game_manager.current_player, "Must be correct player's turn"]
    }
  end
end
