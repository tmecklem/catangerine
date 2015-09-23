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
      unvisited_segments = player_roads.dup
      visited_sets = []
      until unvisited_segments.empty?
        road = unvisited_segments.shift
        connected_road = ConnectedRoad.new
        visited_sets << connected_road
        visit_road(road, unvisited_segments, connected_road)
      end
      visited_sets
    end

    def visit_road(segment, unvisited_segments, connected_road)
      connected_road.road_segments << segment
      unvisited_connected_segments(segment, unvisited_segments).each do |connected_segment|
        unvisited_segments.delete(connected_segment)
        visit_road(connected_segment, unvisited_segments, connected_road)
      end
    end

    def unvisited_connected_segments(segment, unvisited_segments)
      segment.connected_segments.select do |connected_segment|
        unvisited_segments.include?(connected_segment)
      end
    end
  end

  # This class represents the concept of a complete section of connected road segments.
  # A player may have several of these.
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
