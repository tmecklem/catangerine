VERTEX = EDGE = Transform(/^(\-?\w+),(\w+)$/) do |name, direction|
  Catangerine::Location.new(name, direction)
end

PLAYER = Transform(/^(player \d+)$/) do |player|
  game_manager.players[player.gsub(/\D/, '').to_i - 1]
end
