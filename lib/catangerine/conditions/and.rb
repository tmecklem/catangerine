module Catangerine
  module Conditions
    AndCondition = lambda { |*conditions|
      lambda { |command, game_manager|
        results = conditions.map do |condition|
          condition.call(command, game_manager)
        end
        [results.all?(&:first), results]
      }
    }
  end
end
