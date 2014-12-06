module Catangerine
  class GameManager
    DEFAULT_OPTIONS = {
      player_count: 3
    }

    attr_reader :board, :players, :current_player

    def initialize(opts = {})
      @options = DEFAULT_OPTIONS.merge(opts)
      player_count = @options[:player_count]
      @options[:board] = BoardConfiguration.configuration(player_count < 5 ? "standard" : "expanded")
      create_players(player_count)
      @commands ||= []
    end

    def start_game
      @board = BoardGenerator.new(@options[:board]).generate
      @current_player = @players.first
    end

    def play(command)
      if command.execute(self)
        @commands << command
        end_turn
      end
      command
    end

    private

    def create_players(player_count)
      @players = player_count.times.map do |player|
        player + 1
      end
    end

    def end_turn
      @current_player = players[(players.index(@current_player) + 1) % players.size]
    end
  end
end
