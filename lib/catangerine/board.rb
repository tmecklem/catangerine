require 'yaml'

module Catangerine
  class Board
    attr_reader :tile_layout, :harbor_layout

    def initialize(tile_layout, harbor_layout)
      @tile_layout = tile_layout
      @harbor_layout = harbor_layout
    end

    def to_s
      board_string = ""
      @tile_layout.each do |tile|
        board_string << "#{tile.to_s}\n"
      end
      @harbor_layout.each do |harbor|
        board_string << "#{harbor.to_s}\n"
      end
      board_string
    end
  end
end
