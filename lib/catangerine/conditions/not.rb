module Catangerine
  module Conditions
    def self.included(base)
      base.extend ClassMethods
    end

    NotCondition = ->(condition) {
      ->(command, game_manager) {
        result = condition.call(command, game_manager)
        [!result.first, "not (#{result[1]})"]
      }
    }

    module ClassMethods
      def Not(*conditions)
        NotCondition.call(*conditions)
      end
    end
  end
end
