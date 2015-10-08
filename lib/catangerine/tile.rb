module Catangerine
  class Tile
    RESOURCE_TYPES = {
      hills: :brick,
      forest: :lumber,
      mountains: :ore,
      fields: :grain,
      pasture: :wool,
      desert: nil
    }

    attr_accessor :position, :terrain, :chit_number

    def initialize(terrain:, chit_number:)
      @terrain = terrain
      @chit_number = chit_number
    end

    def location
      position.location
    end

    def resource_type
      RESOURCE_TYPES[terrain]
    end

    def touching_settlements
      position.touching_vertices.values.map(&:settlement).compact
    end

    def to_s
      "#{@resource_type} : #{@chit_number}"
    end
  end
end
