module Catangerine
  class GameManager
    DEFAULT_OPTIONS = {
      player_count: 3
    }

    attr_reader :board

    def initialize(opts = {})
      @options = DEFAULT_OPTIONS.merge(opts)
      @options[:board] = BoardConfiguration.configuration(@options[:player_count] < 5 ? "standard" : "expanded")
    end

    def start_game
      @board = BoardGenerator.new(@options[:board]).generate
    end
  end
end
