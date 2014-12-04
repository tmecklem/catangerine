module Catangerine
  class SparseArray
    attr_reader :hash

    def initialize
      @hash = {}
    end

    def [](key)
      hash[key] ||= {}
    end

    def add(hex, obj)
      hex = hex.to_hex
      self[hex.q][hex.r] = obj
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
