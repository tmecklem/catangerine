VERTEX = EDGE = Transform /^(\-?\d+),(\-?\d+),(\w+)$/ do |q, r, v|
  [q.to_i, r.to_i, v.to_sym]
end

Then(/^it should be player (\d+)'s turn$/) do |player_number|
  expect(game_manager.current_player).to eq game_manager.players[player_number.to_i - 1]
end

When(/^I place a settlement at (#{VERTEX}) and a road at (#{EDGE})$/) do |vertex, edge|
  @command = Catangerine::Commands::AddSettlementAndRoad.new(@current_player, *vertex, *edge)
  game_manager.play(@command)
  expect(@command.success).to be_truthy
end

Then(/^the board should contain a settlement at (#{VERTEX})$/) do |vertex|
  expect(game_manager.board.vertex_at(*vertex).object.player).to eq(@current_player)
end

Then(/^the board should contain a road at (#{EDGE})$/) do |edge|
  expect(game_manager.board.edge_at(*edge).object.player).to eq(@current_player)
end
