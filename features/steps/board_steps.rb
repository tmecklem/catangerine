Then(/^the board should have (standard|expanded) tiles$/) do |game_type|
  expect(tile_counts).to eq board_configuration(game_type)[:tile_counts]
end

Then(/^the board should have (standard|expanded) chits$/) do |game_type|
  expected_desert_tile_count = board_configuration(game_type)[:tile_counts][:desert]
  expected_chit_counts = board_configuration(game_type)[:chit_counts].merge(0 => expected_desert_tile_count)
  expect(chit_counts).to eq expected_chit_counts
end

Then(/^the board should have (standard|expanded) harbors$/) do |game_type|
  expect(harbor_counts).to eq board_configuration(game_type)[:harbor_counts]
end

Then(/^the board should be in (.*?) state$/) do |state|
  expect(board.state).to eq state.to_sym
end

Then(/^the board should contain a settlement for (#{PLAYER}) at (#{VERTEX})$/) do |player, vertex|
  expect(game_manager.board.settlement_at(vertex).player).to eq(player)
end

Then(/^the board should contain a road for (#{PLAYER}) at (#{EDGE})$/) do |player, edge|
  expect(game_manager.board.road_at(edge)).not_to be_nil
  expect(game_manager.board.road_at(edge).player).to eq player
end

Then(/^the board should not contain a road for (#{PLAYER}) at (#{EDGE})$/) do |player, edge|
  actual_player = game_manager.board.road_at(edge) && game_manager.board.road_at(edge).player
  expect(actual_player).not_to eq player
end

Given(/^the board has the following items:$/) do |table|
  table.hashes.select { |row| row['type'] == "settlement" }.each do |row|
    location = Catangerine::Location.new(*(row['location'].split(',')))
    settlement = Catangerine::Settlement.new(game_manager.players[row['player'].to_i - 1])
    board.add_settlement(settlement, location)
  end
  table.hashes.select { |row| row['type'] == "road" }.each do |row|
    location = Catangerine::Location.new(*(row['location'].split(',')))
    road = Catangerine::Road.new(game_manager.players[row['player'].to_i - 1])
    board.add_road(road, location)
  end
end

Then(/^the robber should be on a desert tile$/) do
  desert_tile_locations = game_manager.board.tiles(:desert).map(&:location)
  robber_location = game_manager.board.robber_location
  expect(robber_location).to_not be nil
  expect(desert_tile_locations).to include(robber_location)
end
