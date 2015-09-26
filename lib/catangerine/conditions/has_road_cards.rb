module Catangerine
  module Conditions
    HasRoadCards = lambda { |command, game_manager|
      resource_cards = command.player.resource_cards
      AndCondition.call(
        -> (_command, _game_manager) { ConditionResult.new(met: resource_cards[:brick] >= 1, detail: 'player must have at least 1 brick card') },
        -> (_command, _game_manager) { ConditionResult.new(met: resource_cards[:lumber] >= 1, detail: 'player must have at least 1 lumber card') }
      ).call(command, game_manager)
    }
  end
end
