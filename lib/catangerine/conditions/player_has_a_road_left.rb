module Catangerine
  module Conditions
    PlayerHasARoadLeft = lambda { |command, game_manager|
      roads_placed_count = game_manager.board.roads(command.player).size
      total_road_count = game_manager.number_of_roads
      ConditionResult.new(met: roads_placed_count < total_road_count, detail: 'player must have a road left to play')
    }
  end
end
