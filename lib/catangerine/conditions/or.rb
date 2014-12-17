module Catangerine
  module Conditions
    Or = ->(*conditions) {
      ->(command, game_manager) {
        results = conditions.map do |condition|
          condition.call(command, game_manager)
        end
        [results.any?(&:first), results]
      }
    }
  end
end
