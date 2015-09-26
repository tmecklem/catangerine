module Catangerine
  module Conditions
    NotCondition = lambda { |condition|
      lambda { |command, game_manager|
        result = condition.call(command, game_manager)
        ConditionResult.new(met: !result.met, detail: "not (#{result.detail})")
      }
    }
  end
end
