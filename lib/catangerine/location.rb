module Catangerine
  class Location
    include Comparable
    attr_accessor :q, :r, :direction

    NEIGHBORS = {
      sw: [-1, 1], se: [ 0, 1], e: [ 1, 0],
      ne: [ 1,-1], nw: [ 0,-1], w: [-1, 0]
    }

    def initialize(*location)
      if (/^[A-Z]+$/ =~ location.first.to_s) == 0
        @q, @r = convert_name_to_coordinates(location.first)
        @direction = location.last.to_sym if location.size == 2
      else
        @q, @r = location[0..1]
        @direction = location.last.to_sym if location.size == 3
      end
    end

    def without_direction
      return self if @direction.nil?
      Location.new(self.q, self.r)
    end

    def <=>(other)
      return q <=> other.q if (q <=> other.q) != 0
      return r <=> other.r if (r <=> other.r) != 0
      return direction <=> other.direction if (direction <=> other.direction) != 0
      0
    end

    alias eql? ==

    def hash
      @q ^ @r ^ (@direction || 0)
    end

    def to_s
      "#{@q}, #{r}"
    end

    private

    def convert_name_to_coordinates(name)
      @@cached_locations ||= build_location_array(100)
      @@cached_locations[name]
    end

    def build_location_array(size)
      location_array = {}
      names = ("A".."ZZ").to_a[0...size]
      hex = [0,0]
      location_array[names.shift] = hex
      scale = 0
      until names.empty?
        scale += 1
        hex = [hex,NEIGHBORS[:nw]].transpose.map {|x| x.reduce(:+)}
        NEIGHBORS.keys.each do |direction|
          scale.times do
            break if names.empty?
            location_array[names.shift] = hex
            hex = [hex,NEIGHBORS[direction]].transpose.map {|x| x.reduce(:+)}
          end
        end
      end
      @@cached_locations = location_array
    end
  end
end
