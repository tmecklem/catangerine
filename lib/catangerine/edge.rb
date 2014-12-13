module Catangerine
  class Edge
    attr_accessor :object
    attr_reader :hex, :direction

    def initialize(hex, direction)
      @hex = hex
      @direction = direction
    end
  end
end
