module Catangerine
  class GameGrid
    attr_reader :hash

    def initialize
      @hash = {}
    end

    def [](key)
      hash[key] ||= {}
    end

    def add(hex)
      self[hex.q][hex.r] = hex
    end

    def rows
      hash.length
    end

    def to_a
      hash.values.each_with_object([]) do |tiles, acc|
        acc.concat(tiles.values)
      end
    end

    alias_method :length, :rows
  end
end
