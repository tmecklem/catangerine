module Catangerine
  module Conditions
    Or = lambda { |*conditions|
      lambda { |command, game_manager|
        results = conditions.map do |condition|
          condition.call(command, game_manager)
        end
        ConditionResult.new(met: results.any?(&:met), detail: results)
      }
    }
  end
end
