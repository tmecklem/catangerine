module Catangerine
  class GameManager
    DEFAULT_OPTIONS = {
      player_count: 3
    }

    attr_reader :board

    def initialize(opts = {})
      @options = DEFAULT_OPTIONS.merge(opts)
      configuration = Configuration.configuration(@options[:player_count] < 5 ? "standard" : "expanded")
      @options = configuration.merge(@options)
    end

    def start_game
      @board = BoardGenerator.new(@options).generate
    end
  end
end
