module Catangerine
  module Conditions
    def self.included(base)
      base.extend ClassMethods
    end

    OrCondition = ->(*conditions) {
      ->(command, game_manager) {
        results = conditions.map do |condition|
          condition.call(command, game_manager)
        end
        [results.any?(&:first), results]
      }
    }

    module ClassMethods
      def Or(*conditions)
        OrCondition.call(*conditions)
      end
    end
  end
end
