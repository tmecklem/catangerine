require_relative 'or'

module Catangerine
  module Conditions
    RoundOne = lambda { |_command, game_manager|
      [game_manager.round == 1, "Round One"]
    }

    RoundTwo = lambda { |_command, game_manager|
      [game_manager.round == 2, "Round Two"]
    }

    SetupRound = lambda { |command, game_manager|
      Or.call(RoundOne, RoundTwo).call(command, game_manager)
    }
  end
end
