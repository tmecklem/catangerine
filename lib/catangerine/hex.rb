module Catangerine
  class Hex
    NEIGHBORS = {
      w: [-1, 0], sw: [-1, 1], se: [0, 1], e: [1, 0], ne: [1, -1], nw: [0, -1]
    }

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

    def face=(face)
      @face = face
      face.position = self
    end

    def neighbor(direction)
      d = NEIGHBORS[direction]
      @board.hex_at(Location.new(location.q + d[0], location.r + d[1]))
    end

    def to_s
      str = "[#{location.q},#{location.r}]\n"
      vertices.each do |_direction, v|
        str << "direction: #{v}\n"
      end
    end

    NEIGHBORS.keys.each do |direction|
      define_method("#{direction}_neighbor") { neighbor(direction) }
    end

    [:sw, :w, :nw].each do |direction|
      define_method("#{direction}_edge") { edges[direction] }
    end

    define_method("top_vertex") { vertices[:t] }
    define_method("bottom_vertex") { vertices[:b] }
  end
end
