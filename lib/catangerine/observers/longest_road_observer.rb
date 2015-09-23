module Observers
  class LongestRoadObserver
    attr_accessor :longest_road_length, :player_with_longest_road_card

    def road_added(board, road, _location)
      player = road.player
      player_roads = board.roads(player)
      length_of_road = longest_player_road_length(player_roads).length
      return unless length_of_road > 4 && length_of_road > (longest_road_length || 0)
      self.longest_road_length = length_of_road
      self.player_with_longest_road_card = player
    end

    private

    def longest_player_road_length(player_roads)
      connected_road_sets(player_roads).max_by(&:length)
    end

    def connected_road_sets(player_roads)
      roads_to_visit = player_roads.dup
      visited_sets = []
      until roads_to_visit.empty?
        road = roads_to_visit.shift
        connected_road = ConnectedRoad.new
        visited_sets << connected_road
        visit_road(road, roads_to_visit, connected_road)
      end
      visited_sets
    end

    def visit_road(road, roads_to_visit, connected_road)
      connected_road.road_segments << road
      road.connected_segments.each do |connected_segment|
        if roads_to_visit.include?(connected_segment)
          roads_to_visit.delete(connected_segment)
          visit_road(connected_segment, roads_to_visit, connected_road)
        end
      end
    end
  end

  class ConnectedRoad
    def road_segments
      @road_segments ||= []
    end

    def length
      road_segments.length
    end

    def to_s
      road_segments.map(&:to_s)
    end
  end
end
