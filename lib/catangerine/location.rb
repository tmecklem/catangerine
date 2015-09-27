module Catangerine
  class Location
    include Comparable
    attr_accessor :q, :r, :direction

    def initialize(*location)
      location_components = location.dup
      if (/^[A-Z]+$/ =~ location_components.first.to_s) == 0
        @q, @r = LocationTranslator.location_for(location_components.shift)
      else
        @q, @r = location_components.shift(2)
      end
      @direction = location_components.map(&:to_sym).first
    end

    def without_direction
      return self if @direction.nil?
      Location.new(q, r)
    end

    def <=>(other)
      return compare_position(other) if compare_position(other) != 0
      compare_direction(other)
    end

    def ==(other)
      return true if super
      to_a == other.to_a
    end

    def to_a
      [q, r, direction].compact
    end

    alias_method :eql?, :==

    def hash
      q ^ r ^ (direction || 0)
    end

    def to_s
      "#{name},#{direction}"
    end

    def name
      LocationTranslator.name_for([q, r])
    end

    private

    def compare_position(other)
      return q <=> other.q if (q <=> other.q) != 0
      return r <=> other.r if (r <=> other.r) != 0
      0
    end

    def compare_direction(other)
      return 0 if direction.nil? && other.direction.nil?
      return -1 if direction.nil?
      return 1 if other.direction.nil?
      direction <=> other.direction
    end
  end
end
