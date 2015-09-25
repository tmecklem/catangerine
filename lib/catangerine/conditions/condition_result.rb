module Catangerine
  module Conditions
    class ConditionResult
      attr_reader :met, :detail

      def initialize(met:, detail: nil)
        @met = met
        @detail = detail
      end

      def met?
        met
      end
    end
  end
end
