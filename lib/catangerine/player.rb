module Catangerine
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

  class Player
    attr_reader :resource_cards

    def initialize
      @resource_cards = {}
    end

    def longest_road_length(player_roads)
      connected_road_sets(player_roads).max_by(&:length)
    end

    def connected_road_sets(player_roads)
      roads_to_visit = player_roads.dup
      visited_sets = []
      until roads_to_visit.empty?
        road = roads_to_visit.shift
        connected_road = Catangerine::ConnectedRoad.new
        visited_sets << connected_road
        visit_road(road, roads_to_visit, connected_road)
      end
      visited_sets
    end

    def visit_road(road, roads_to_visit, connected_road)
      connected_road.road_segments << road
      road.connected_segments.each do |connected_segment|
        if(roads_to_visit.include?(connected_segment))
          roads_to_visit.delete(connected_segment)
          visit_road(connected_segment, roads_to_visit, connected_road)
        end
      end
    end
  end
end
