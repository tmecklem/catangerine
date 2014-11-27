module Catangerine
  class Tile
    attr_reader :resource_type, :chit_number

    def initialize(resource_type, chit_number)
      @resource_type = resource_type
      @chit_number = chit_number
    end
  end
end
