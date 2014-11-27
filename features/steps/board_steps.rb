Given(/^(\d+) players?$/) do |player_count|
  @board_generators = [Catangerine::BoardGenerator.new(player_count: player_count.to_i)]
end

When(/^the boards? generates?$/) do
  @boards = @board_generators.map { |board_generator| board_generator.generate }
end

Then(/^the board should have (standard|expanded) tiles$/) do |game_type|
  tile_counts = Hash[ @boards.first.tile_layout.group_by { |tile| tile.resource_type }.map { |k, v| [k, v.size] } ]
  expect(tile_counts).to eq Catangerine::Configuration.configuration(game_type)[:tile_counts]
end

Then(/^the board should have (standard|expanded) chits$/) do |game_type|
  chit_counts = Hash[ @boards.first.tile_layout.group_by { |tile| tile.chit_number }.map { |k, v| [k, v.size] } ]
  desert_tile_count = Catangerine::Configuration.configuration(game_type)[:tile_counts][:desert]
  expect(chit_counts).to eq Catangerine::Configuration.configuration(game_type)[:chit_counts].merge({0=>desert_tile_count})
end

Then(/^the board should have (standard|expanded) harbors$/) do |game_type|
  harbor_counts = Hash[ @boards.first.harbor_layout.group_by { |harbor| harbor }.map { |k, v| [k, v.size] } ]
  expect(harbor_counts).to eq Catangerine::Configuration.configuration(game_type)[:harbor_counts]
end

Given(/^(\d+) boards$/) do |board_count|
  @board_generators = board_count.to_i.times.map do |i|
    Catangerine::BoardGenerator.new
  end
end

Then(/^the boards should have different tile and chit layouts$/) do
  tile_layouts = @boards.map(&:tile_layout)
  expect(tile_layouts[0]).to_not eq tile_layouts[1]
end
