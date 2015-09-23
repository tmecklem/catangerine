module Catangerine
  module Conditions
    NotCondition = lambda { |condition|
      lambda { |command, game_manager|
        result = condition.call(command, game_manager)
        [!result.first, "not (#{result[1]})"]
      }
    }
  end
end
