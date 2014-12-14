module Catangerine
  module Conditions
    def self.included(base)
      base.extend ClassMethods
    end

    AndCondition = ->(*conditions) {
      ->(command, game_manager) {
        results = conditions.map do |condition|
          condition.call(command, game_manager)
        end
        [results.all?(&:first), results]
      }
    }

    module ClassMethods
      def Or(*conditions)
        AndCondition.call(*conditions)
      end
    end
  end
end
