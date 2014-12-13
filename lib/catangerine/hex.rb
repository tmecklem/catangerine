module Catangerine
  class Hex
    attr_accessor :face
    attr_reader :location, :edges, :vertices

    def initialize(board, location)
      @board = board
      @location = location
      @edges = {
        sw: Edge.new(self, :sw),
        nw: Edge.new(self, :nw),
        w: Edge.new(self, :w)
      }
      @vertices = {
        t: Vertex.new(self, :t),
        b: Vertex.new(self, :b)
      }
    end

    NEIGHBORS = {
      sw: [-1, 1], se: [ 0, 1], e: [ 1, 0],
      ne: [ 1,-1], nw: [ 0,-1], w: [-1, 0]
    }

    def neighbor(direction)
      d = NEIGHBORS[direction]
      @board.hex_at(Location.new(location.q + d[0], location.r + d[1]))
    end

    def to_s
      str = "[#{q},#{r}]\n"
      vertices.each do |direction, v|
        str << "direction: #{v}\n"
      end
    end
  end
end
