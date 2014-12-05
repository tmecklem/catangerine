require 'yaml'

module Catangerine
  class BoardGenerator
    REQUIRED_OPTIONS = [:tile_counts, :chit_counts, :harbor_counts]

    def initialize(opts)
      BoardGenerator.validate_options(opts)
      @options = opts
    end

    def self.validate_options(opts)
      REQUIRED_OPTIONS.each do |required_option|
        raise ArgumentError, "#{required_option.to_s} is a required option" unless opts.has_key?(required_option)
      end
    end

    def generate
      Board.new(layout_tiles(generate_tiles), generate_harbors)
    end

    private

    def layout_tiles(tiles)
      layout = GameGrid.new
      hex = Hex.new(0,0)
      layout.add(hex, tiles.shift)
      scale = 0
      until tiles.empty?
        scale += 1
        hex = hex.neighbor(4)
        6.times do |i|
          scale.times do
            break if tiles.empty?
            layout.add(hex, tiles.shift)
            hex = hex.neighbor(i)
          end
        end
      end
      layout
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

    def generate_harbors
      harbor_layout = []
      @options[:harbor_counts].each do |type, count|
        count.times do |i|
          harbor_layout << type
        end
      end
      harbor_layout.shuffle!
    end
  end
end
