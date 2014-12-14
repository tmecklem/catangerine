module Catangerine
  module Conditions
    extend ClassMethods

    RoundOne = ->(command, game_manager) {
      [game_manager.round == 1, "Round One"]
    }

    RoundTwo = ->(command, game_manager) {
      [game_manager.round == 2, "Round Two"]
    }

    SetupRound = ->(command, game_manager) {
      Or(RoundOne, RoundTwo).call(command, game_manager)
    }
  end
end
