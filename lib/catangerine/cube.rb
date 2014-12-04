module Catangerine
  Cube = Struct.new(:x, :y, :z) do
    def to_hex
      Hex.new(x, z)
    end
  end
end
