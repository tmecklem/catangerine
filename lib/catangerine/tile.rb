module Catangerine
  class Tile
    attr_reader :location, :resource_type, :chit_number

    def initialize(attrs)
      @resource_type = attrs[:resource_type]
      @chit_number = attrs[:chit_number]
    end

    def to_s
      "#{@resource_type.to_s} : #{@chit_number}"
    end
  end
end
