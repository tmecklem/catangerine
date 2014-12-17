module Catangerine
  module Commands
    class Command
      include Catangerine::Conditions

      attr_reader :player, :success, :errors, :attributes

      def initialize(player, attrs = {})
        @player = player
        @attributes = attrs
        @conditions = [CorrectPlayerTurn].concat(Array(command_conditions))
      end

      def execute(game_manager)
        return @success = false if !validate_command(game_manager)
        execute_after_validation(game_manager)
      end

      protected

      def execute_after_validation(game_manager)
        raise NotImplementedError, "#{self.class.name} does not implement #{__method__}"
      end

      def command_conditions
        #condition hook for subclasses
      end

      def validate_command(game_manager)
        @errors = @conditions.map do |condition|
          condition.call(self, game_manager)
        end.select { |result| !result.first }
        @errors.empty?
      end
    end
  end
end

Dir[File.dirname(__FILE__) + '/commands/*.rb'].each {|file| require file }
