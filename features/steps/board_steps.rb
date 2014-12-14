Given(/^a (\d+) player game at the start of round (\d+)$/) do |player_count, game_round|
  self.game_manager = create_game_manager(player_count)
  game_manager.start_game
  (player_count.to_i*(game_round.to_i-1)).times do
    game_manager.end_turn
  end
  @current_player = game_manager.current_player

  expect(game_manager.round).to eq(game_round.to_i),
    "Expected game to be on round #{game_round}, but was #{game_manager.round}"
end

Then(/^the board should have (standard|expanded) tiles$/) do |game_type|
  expect(tile_counts).to eq board_configuration(game_type)[:tile_counts]
end

Then(/^the board should have (standard|expanded) chits$/) do |game_type|
  expected_desert_tile_count = board_configuration(game_type)[:tile_counts][:desert]
  expected_chit_counts = board_configuration(game_type)[:chit_counts].merge({0=>expected_desert_tile_count})
  expect(chit_counts).to eq expected_chit_counts
end

Then(/^the board should have (standard|expanded) harbors$/) do |game_type|
  expect(harbor_counts).to eq board_configuration(game_type)[:harbor_counts]
end

Then(/^the board should be in (.*?) state$/) do |state|
  expect(board.state).to eq state.to_sym
end

Then(/^the board should contain a settlement at (#{VERTEX})$/) do |vertex|
  expect(game_manager.board.settlement_at(*vertex).player).to eq(@current_player)
end

Then(/^the board should contain a road at (#{EDGE})$/) do |edge|
  expect(game_manager.board.road_at(*edge).player).to eq(@current_player)
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
