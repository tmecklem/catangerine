Given(/^(\d+) players?$/) do |player_count|
  @boards = [Catangerine::Board.new(player_count: 3)]
end

When(/^the boards? generates?$/) do
  @boards.each(&:generate)
end

Then(/^the board should have (?:standard) tiles$/) do
  tile_counts = Hash[ @boards.first.tile_layout.group_by { |tile| tile.resource_type }.map { |k, v| [k, v.size] } ]
  expect(tile_counts).to eq Catangerine::Configuration.default_configuration[:tile_counts]
end

Then(/^the board should have (?:standard) chits$/) do
  chit_counts = Hash[ @boards.first.tile_layout.group_by { |tile| tile.chit_number }.map { |k, v| [k, v.size] } ]
  expect(chit_counts).to eq Catangerine::Configuration.default_configuration[:chit_counts].merge({0=>1})
end

Given(/^(\d+) boards$/) do |board_count|
  @boards = board_count.to_i.times.map do |i|
    Catangerine::Board.new
  end
end

Then(/^the boards should have different tile and chit layouts$/) do
  tile_layouts = @boards.map(&:tile_layout)
  expect(tile_layouts[0]).to_not eq tile_layouts[1]
end
