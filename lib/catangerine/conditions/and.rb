module Catangerine
  module Conditions
    AndCondition = lambda { |*conditions|
      lambda { |command, game_manager|
        results = conditions.map do |condition|
          condition.call(command, game_manager)
        end
        ConditionResult.new(met: results.all?(&:met), detail: "(#{results.select(&:unmet?).map(&:detail).join(' and ')})")
      }
    }
  end
end
