require_relative 'or'

module Catangerine
  module Conditions
    RoundOne = lambda { |_command, game_manager|
      ConditionResult.new(met: game_manager.round == 1, detail: "Round One")
    }

    RoundTwo = lambda { |_command, game_manager|
      ConditionResult.new(met: game_manager.round == 2, detail: "Round Two")
    }

    SetupRound = lambda { |command, game_manager|
      Or.call(RoundOne, RoundTwo).call(command, game_manager)
    }
  end
end
