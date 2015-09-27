module Catangerine
  class LocationTranslator
    NEIGHBORS = {
      w: [-1, 0], sw: [-1, 1], se: [0, 1], e: [1, 0], ne: [1, -1], nw: [0, -1]
    }

    def self.cached_locations
      @cached_locations ||= {}
    end

    def self.location_for(name)
      build_location_array(name) unless cached_locations[name]
      cached_locations[name]
    end

    def self.name_for(location)
      build_location_array('ZZ') unless cached_locations['ZZ']

      cached_locations.detect { |_key, l| location == l }.first
    end

    def self.names(end_name)
      ("A"..end_name).to_a
    end

    def self.build_location_array(name)
      remaining_names = names(name)
      root = [0, 0]
      cached_locations[remaining_names.shift] ||= root
      build_locations_in_counter_clockwise_concentric_circles(root, remaining_names)
    end

    def self.build_locations_in_counter_clockwise_concentric_circles(root, remaining_names, radius = 0)
      hex = root
      radius = 0
      until remaining_names.empty? # stop when we run out
        # move hex pointer NE, but don't store it so that we start in the right spot
        hex = neighbor(hex, :ne)
        radius += 1 # widen the concentric circle one more
        NEIGHBORS.keys.each do |direction| # turn clockwise one edge
          radius.times do # go straight in this direction radius times
            break if remaining_names.empty? # stop when we run out
            hex = neighbor(hex, direction)
            cached_locations[remaining_names.shift] ||= hex
          end
        end
      end
    end

    # takes a hex coord array and a direction and returns hex coords for neighbor in that direction
    def self.neighbor(hex, direction)
      hex.zip(NEIGHBORS[direction]).map { |x| x.reduce(:+) }
    end
  end
end
