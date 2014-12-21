module Catangerine
  class Road
    attr_reader :player
    attr_accessor :position

    def initialize(player)
      @player = player
    end
  end
end
