module Catangerine
  module Commands
    class Command
      attr_reader :player, :success, :errors, :attributes

      def initialize(player, attrs = {})
        @player = player
        @attributes = attrs
      end

      def execute(game_manager)
        raise NotImplementedError, "#{self.class.name} does not implement #{__method__}"
      end
    end
  end
end

Dir[File.dirname(__FILE__) + '/commands/*.rb'].each {|file| require file }
