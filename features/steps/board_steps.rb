include BoardHarness
include BoardConfigurationHarness

def board
  @boards.first
end

def game_manager
  @game_managers.first
end

Given(/^(\d+) players?$/) do |player_count|
  @game_managers = [Catangerine::GameManager.new(player_count: player_count.to_i)]
end

When(/^the games? starts?$/) do
  @boards = @game_managers.map { |game_manager| game_manager.start_game }
end

Then(/^the board should have (standard|expanded) tiles$/) do |game_type|
  expect(tile_counts(board)).to eq configuration(game_type)[:tile_counts]
end

Then(/^the board should have (standard|expanded) chits$/) do |game_type|
  expected_desert_tile_count = configuration(game_type)[:tile_counts][:desert]
  expected_chit_counts = configuration(game_type)[:chit_counts].merge({0=>expected_desert_tile_count})
  expect(chit_counts(board)).to eq expected_chit_counts
end

Then(/^the board should have (standard|expanded) harbors$/) do |game_type|
  expect(harbor_counts(board)).to eq configuration(game_type)[:harbor_counts]
end

Given(/^(\d+) games?$/) do |games_count|
  @game_managers = games_count.to_i.times.map do |i|
    Catangerine::GameManager.new
  end
end

Then(/^the boards should have different tile and chit layouts$/) do
  tiles = @boards.map(&:tiles)
  expect(tiles[0]).to_not eq tiles[1]
end

Then(/^the board should be in (.*?) state$/) do |state|
  expect(board.state).to eq state.to_sym
end
