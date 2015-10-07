module Observers
  class LongestRoadObserver
    attr_reader :game_manager, :longest_road_length, :player_with_longest_road_card

    def initialize(game_manager)
      @game_manager = game_manager
    end

    def road_added(board, road, _location)
      player = road.player
      length_of_road = longest_player_road_length(player, board)
      return unless length_of_road > 4 && length_of_road > (longest_road_length || 0)
      set_longest_road(player, length_of_road)
    end

    def settlement_added(board, _settlement, _location)
      return if longest_player_road_length(player_with_longest_road_card, board) == longest_road_length
      recalculate_longest_road(board)
    end

    private

    def recalculate_longest_road(board)
      set_longest_road(nil, nil)
      game_manager.players.each do |player|
        length_of_road = longest_player_road_length(player, board)
        next unless length_of_road && length_of_road > 4
        if length_of_road == longest_road_length
          @player_with_longest_road_card = nil
        elsif longest_road_length.nil? || length_of_road > longest_road_length
          set_longest_road(player, length_of_road)
        end
      end
    end

    def set_longest_road(player, length)
      @player_with_longest_road_card = player
      @longest_road_length = length
    end

    def longest_player_road_length(player, board)
      player_roads = board.roads(player)
      LongestRoad.new(road_segments: player_roads).length
    end
  end
end
