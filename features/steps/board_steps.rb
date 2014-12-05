Given(/^(\d+) players?$/) do |player_count|
  @game_managers = [Catangerine::GameManager.new(player_count: player_count.to_i)]
end

When(/^the games? starts?$/) do
  @boards = @game_managers.map { |game_manager| game_manager.start_game }
end

Then(/^the board should have (standard|expanded) tiles$/) do |game_type|
  tile_counts = Hash[ @boards.first.tiles.group_by { |tile| tile.resource_type }.map { |k, v| [k, v.size] } ]
  expect(tile_counts).to eq Catangerine::BoardConfiguration.configuration(game_type)[:tile_counts]
end

Then(/^the board should have (standard|expanded) chits$/) do |game_type|
  chit_counts = Hash[ @boards.first.tiles.group_by { |tile| tile.chit_number }.map { |k, v| [k, v.size] } ]
  desert_tile_count = Catangerine::BoardConfiguration.configuration(game_type)[:tile_counts][:desert]
  expect(chit_counts).to eq Catangerine::BoardConfiguration.configuration(game_type)[:chit_counts].merge({0=>desert_tile_count})
end

Then(/^the board should have (standard|expanded) harbors$/) do |game_type|
  harbor_counts = Hash[ @boards.first.harbors.map(&:harbor_type).group_by { |harbor| harbor }.map { |k, v| [k, v.size] } ]
  expect(harbor_counts).to eq Catangerine::BoardConfiguration.configuration(game_type)[:harbor_counts]
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
