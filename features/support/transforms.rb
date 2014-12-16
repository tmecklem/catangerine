VERTEX = EDGE = Transform /^(\-?\w+),(\w+)$/ do |name, direction|
  Catangerine::Location.new(name, direction)
end

PLAYER = Transform /^(I|player \d+)$/ do |player|
  player == "I" ? player = @current_player : game_manager.players[player.gsub(/\D/,'').to_i - 1]
end
