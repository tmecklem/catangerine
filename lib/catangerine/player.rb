module Catangerine
  class Player
    attr_reader :resource_cards

    def initialize
      @resource_cards = {}
    end

    def connected_road_sets(player_roads)
      roads_to_visit = player_roads.dup
      visited_sets = []
      until roads_to_visit.empty?
        road = roads_to_visit.shift
        visited = []
        visited_sets << visited
        visit_road(road, roads_to_visit, visited)
      end
      visited_sets
    end

    def visit_road(road, roads_to_visit, visited)
      visited << road
      road.connected_roads.each do |connected_road|
        if(roads_to_visit.include?(connected_road))
          roads_to_visit.delete(connected_road)
          visit_road(connected_road, roads_to_visit, visited)
        end
      end
    end
  end
end
