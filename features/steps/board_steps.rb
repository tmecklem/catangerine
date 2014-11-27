Given(/^(\d+) players?$/) do |player_count|
  @boards = [Catangerine::Board.new(player_count: 3)]
end

When(/^the boards? generates?$/) do
  @boards.each(&:generate)
end

Then(/^the board should have (standard) tiles$/) do |tile_type|
  tile_counts = Hash[ @boards.first.tile_layout.group_by { |x| x }.map { |k, v| [k, v.size] } ]
  expect(tile_counts).to eq Catangerine::Board::STANDARD_TILE_COUNTS
end

Given(/^(\d+) boards$/) do |board_count|
  @boards = board_count.to_i.times.map do |i|
    Catangerine::Board.new
  end
end

Then(/^the boards should have different tile layouts$/) do
  tile_layouts = @boards.map(&:tile_layout)
  expect(tile_layouts[0]).to_not eq tile_layouts[1]
end
