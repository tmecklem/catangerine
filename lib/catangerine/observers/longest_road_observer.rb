module Observers
  class LongestRoadObserver
    attr_accessor :longest_road_length, :player_with_longest_road_card

    def road_added(board, road, _location)
      player = road.player
      player_roads = board.roads(player)
      length_of_road = longest_player_road_length(player_roads)
      return unless length_of_road > 4 && length_of_road > (longest_road_length || 0)
      self.longest_road_length = length_of_road
      self.player_with_longest_road_card = player
    end

    private

    def longest_player_road_length(player_roads)
      LongestRoad.new(road_segments: player_roads).length
    end
  end
end
