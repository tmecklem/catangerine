require 'yaml'

module Catangerine
  class Board
    attr_reader :tile_layout, :harbor_layout

    def initialize(tile_layout, harbor_layout)
      @tile_layout = tile_layout
      @harbor_layout = harbor_layout
    end
  end
end
