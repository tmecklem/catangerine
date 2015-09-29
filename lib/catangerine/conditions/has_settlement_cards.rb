module Catangerine
  module Conditions
    HasSettlementCards = lambda { |command, game_manager|
      resource_cards = command.player.resource_cards
      conditions = [:brick, :lumber, :wool, :grain].map { |resource|
        lambda { |_command, _game_manager|
          ConditionResult.new(met: resource_cards[resource] >= 1, detail: "player must have at least 1 #{resource} card")
        }
      }
      AndCondition.call(*conditions).call(command, game_manager)
    }
  end
end
