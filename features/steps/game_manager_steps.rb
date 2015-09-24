Then(/^it should be player (\d+)'s turn$/) do |player_number|
  expect(game_manager.current_player).to eq game_manager.players[player_number.to_i - 1]
end

When(/^(#{PLAYER}) (?:try to |tries to )?place a settlement at (#{VERTEX}) and a road at (#{EDGE})$/) do |player, vertex, edge|
  @command = Catangerine::Commands::AddSettlementAndRoad.new(player, settlement_location: vertex, road_location: edge)
  game_manager.play(@command)
end

When(/^(#{PLAYER}) (?:try to |tries to )?place a settlement at (#{VERTEX})$/) do |player, vertex|
  @command = Catangerine::Commands::AddSettlement.new(player, settlement_location: vertex)
  game_manager.play(@command)
end

When(/^(#{PLAYER}) (?:try to |tries to )?place a road at (#{EDGE})$/) do |player, edge|
  @command = Catangerine::Commands::AddRoad.new(player, road_location: edge)
  game_manager.play(@command)
  puts @command.errors unless @command.success
end

Then(/^it should not succeed$/) do
  expect(@command.success).to be_falsy
end

Then(/^I should receive resource cards from the following tiles:$/) do |table|
  player = game_manager.players.first
  expected_resource_cards = {}
  table.hashes.each do |row|
    location = Catangerine::Location.new(row['tile'])
    tile = board.hex_at(location).face
    expected_resource_cards[tile.resource_type] ||= 0
    expected_resource_cards[tile.resource_type] += 1
  end
  expect(player.resource_cards).to eq expected_resource_cards
end

Then(/^player (\d+) should have the longest road card$/) do |player_number|
  player = game_manager.players[player_number.to_i - 1]
  expect(game_manager.player_with_longest_road_card).to eq player
end

Then(/^I should receive the longest road card$/) do
  player = game_manager.players.first
  expect(game_manager.player_with_longest_road_card).to eq player
end

Then(/^I should not receive the longest road card$/) do
  player = game_manager.players.first
  expect(game_manager.player_with_longest_road_card).not_to eq player
end
