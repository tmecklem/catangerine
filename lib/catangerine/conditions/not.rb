module Catangerine
  module Conditions
    NotCondition = ->(condition) {
      ->(command, game_manager) {
        result = condition.call(command, game_manager)
        [!result.first, "not (#{result[1]})"]
      }
    }
  end
end
