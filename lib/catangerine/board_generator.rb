require 'yaml'

module Catangerine
  class BoardGenerator
    REQUIRED_OPTIONS = [:tile_counts, :chit_counts, :harbor_counts, :harbor_locations]

    def initialize(opts)
      BoardGenerator.validate_options(opts)
      @options = opts
    end

    def generate
      board = Board.new
      layout_tiles(board, generate_tiles)
      layout_harbors(board, generate_harbors)
      place_robber(board)
      board
    end

    private

    def self.validate_options(opts)
      REQUIRED_OPTIONS.each do |required_option|
        raise ArgumentError, "#{required_option.to_s} is a required option" unless opts.has_key?(required_option)
      end
    end

    def layout_tiles(board, tiles)
      hex = board.hex_at(Location.new(0,0))
      hex.face = tiles.shift
      scale = 0
      until tiles.empty?
        scale += 1
        hex = hex.neighbor(:nw)
        Hex::NEIGHBORS.keys.each do |direction|
          scale.times do
            break if tiles.empty?
            hex.face = tiles.shift
            hex = hex.neighbor(direction)
          end
        end
      end
      board
    end

    def generate_tiles
      tiles = []
      chits = generate_chits
      @options[:tile_counts].each do |type, count|
        count.times do |i|
          chit_number = type!=:desert ? chits.shift : 0
          tiles << Tile.new(resource_type: type, chit_number: chit_number)
        end
      end
      tiles.shuffle!
    end

    def generate_chits
      chits = []
      @options[:chit_counts].each do |num, count|
        count.times do |i|
          chits << num
        end
      end
      chits.shuffle!
    end

    def layout_harbors(board, harbors)
      @options[:harbor_locations].zip(harbors).each do |locations, harbor_type|
        harbor = Harbor.new(harbor_type)
        locations.each do |location|
          board.add_harbor(harbor, Location.new(*location))
        end
      end
    end

    def generate_harbors
      harbor_layout = []
      @options[:harbor_counts].each do |type, count|
        count.times do |i|
          harbor_layout << type
        end
      end
      harbor_layout.shuffle!
    end

    def place_robber(board)
      board.move_robber(board.tiles(:desert).first.location)
    end
  end
end
