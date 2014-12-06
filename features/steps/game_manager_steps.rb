include GameManagerHarness
include BoardHarness

Then(/^it should be player (\d+)'s turn$/) do |player_number|
  @current_player = game_manager.current_player
  expect(@current_player).to eq game_manager.players[player_number.to_i - 1]
end

When(/^player (\d+) places a settlement at (\-?\d+),(\-?\d+),(\w+) and a road at (\-?\d+),(\-?\d+),(\w+)$/) do |player_number, q, r, v, q2, r2, e|
  @command = Catangerine::Commands::AddSettlementAndRoad.new(@current_player, q.to_i, r.to_i, v.to_sym, q2.to_i, r2.to_i, e.to_sym)
  game_manager.play(@command)
end

Then(/^the command should succeed$/) do
  expect(@command.success).to be_truthy
end

Then(/^the board should contain a settlement at (\-?\d+),(\-?\d+),(\w+)$/) do |q, r, v|
  expect(game_manager.board.hex_at(q.to_i, r.to_i).vertices[v.to_sym].player).to eq(@current_player)
end

Then(/^the board should contain a road at (\-?\d+),(\-?\d+),(\w+)$/) do |q, r, e|
  expect(game_manager.board.hex_at(q.to_i, r.to_i).edges[e.to_sym].player).to eq(@current_player)
end
