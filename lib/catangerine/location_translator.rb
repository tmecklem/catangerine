module Catangerine
  class LocationTranslator
    NEIGHBORS = {
      w: [-1, 0], sw: [-1, 1], se: [0, 1], e: [1, 0], ne: [1, -1], nw: [0, -1]
    }

    def self.cached_locations
      @cached_locations ||= {}
    end

    def self.location_for(name)
      build_location_array(names.last) unless cached_locations.key?(names.last)
      cached_locations[name]
    end

    def self.name_for(location)
      build_location_array('ZZ') unless cached_locations.key?('ZZ')
      cached_locations.detect { |_key, l| location == l }.first
    end

    def self.names
      ("A".."ZZ").to_a
    end

    def self.build_location_array(name)
      hex = [0, 0]
      remaining_names = names
      cached_locations[remaining_names.shift] ||= hex
      scale = 0
      until cached_locations[name] || remaining_names.empty?
        scale += 1
        hex = [hex, NEIGHBORS[:ne]].transpose.map { |x| x.reduce(:+) }
        NEIGHBORS.keys.each do |direction|
          scale.times do
            break if cached_locations[name] || remaining_names.empty?
            hex = [hex, NEIGHBORS[direction]].transpose.map { |x| x.reduce(:+) }
            cached_locations[remaining_names.shift] ||= hex
          end
        end
      end
    end
  end
end
