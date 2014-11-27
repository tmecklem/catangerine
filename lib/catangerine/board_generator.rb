require 'yaml'

module Catangerine
  class BoardGenerator
    def initialize(options)
      @options = options
    end

    def generate
      Board.new(generate_tiles, generate_harbors)
    end

    private

    def generate_tiles
      chits = generate_chits
      tile_layout = []
      @options[:tile_counts].each do |type, count|
        count.times do |i|
          chit_number = type!=:desert ? chits.shift : 0
          tile_layout << Tile.new(type, chit_number)
        end
      end
      tile_layout.shuffle!
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
