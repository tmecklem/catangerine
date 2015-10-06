module Catangerine
  class GameManager
    DEFAULT_OPTIONS = {
      player_count: 3,
      number_of_roads: 15,
      number_of_settlements: 5
    }

    attr_reader :board, :players, :current_player, :round, :number_of_roads, :number_of_settlements

    def initialize(opts = {})
      @options = DEFAULT_OPTIONS.merge(opts)
      player_count = @options[:player_count]
      @number_of_roads = @options[:number_of_roads]
      @number_of_settlements = @options[:number_of_settlements]
      @options[:board] = BoardConfiguration.configuration(player_count < 5 ? "standard" : "expanded")
      create_players(player_count)
      @commands ||= []
    end

    def start_game
      @board = BoardGenerator.new(@options[:board]).generate
      @longest_road_observer = Observers::LongestRoadObserver.new
      @board.add_observer(@longest_road_observer)
      @current_player = @players.first
      @round = 1
      self
    end

    def play(command)
      if command.execute(self)
        @commands << command
        end_turn
      end
      command
    end

    def end_turn
      @current_player = players[(players.index(current_player) + 1) % players.size]
      @round += 1 if current_player == players.first
    end

    def player_with_longest_road_card
      @longest_road_observer.player_with_longest_road_card
    end

    private

    def create_players(player_count)
      player_colors = [:red, :blue, :white, :orange, :green, :brown]
      @players = player_count.times.map do |index|
        Player.new(color: player_colors[index], position: index)
      end
    end
  end
end
