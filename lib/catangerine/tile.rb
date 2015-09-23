module Catangerine
  class Tile
    attr_accessor :position, :resource_type, :chit_number

    def initialize(attrs)
      @resource_type = attrs[:resource_type]
      @chit_number = attrs[:chit_number]
    end

    def location
      position.location
    end

    def to_s
      "#{@resource_type} : #{@chit_number}"
    end
  end
end
