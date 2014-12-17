require_relative 'or'

module Catangerine
  module Conditions
    RoundOne = ->(command, game_manager) {
      [game_manager.round == 1, "Round One"]
    }

    RoundTwo = ->(command, game_manager) {
      [game_manager.round == 2, "Round Two"]
    }

    SetupRound = ->(command, game_manager) {
      Or.call(RoundOne, RoundTwo).call(command, game_manager)
    }
  end
end
