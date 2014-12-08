VERTEX = EDGE = Transform /^(\-?\d+),(\-?\d+),(\w+)$/ do |q, r, v|
  [q.to_i, r.to_i, v.to_sym]
end

Then(/^it should be player (\d+)'s turn$/) do |player_number|
  @current_player = game_manager.current_player
  expect(@current_player).to eq game_manager.players[player_number.to_i - 1]
end

When(/^player (\d+) places a settlement at (#{VERTEX}) and a road at (#{EDGE})$/) do |player_number, vertex, edge|
  @command = Catangerine::Commands::AddSettlementAndRoad.new(@current_player, *vertex, *edge)
  game_manager.play(@command)
  expect(@command.success).to be_truthy
end

Then(/^the board should contain a settlement at (#{VERTEX})$/) do |vertex|
  expect(game_manager.board.hex_at(vertex[0], vertex[1]).vertices[vertex[2]].player).to eq(@current_player)
end

Then(/^the board should contain a road at (#{EDGE})$/) do |edge|
  expect(game_manager.board.hex_at(edge[0], edge[1]).edges[edge[2]].player).to eq(@current_player)
end
