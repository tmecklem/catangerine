module Catangerine
  class Player
    attr_reader :resource_cards

    def acquire_cards(type, count)
      resource_cards[type.to_sym] += count
    end

    def return_cards(type, count)
      resource_cards[type.to_sym] -= count
    end

    def resource_cards
      @resource_cards ||= {
        brick: 0,
        lumber: 0,
        ore: 0,
        grain: 0,
        wool: 0
      }
    end
  end
end
