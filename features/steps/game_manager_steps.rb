Then(/^it should be player (\d+)'s turn$/) do |player_number|
  expect(game_manager.current_player).to eq game_manager.players[player_number.to_i - 1]
end

When(/^I place a settlement at (#{VERTEX}) and a road at (#{EDGE})$/) do |vertex, edge|
  @command = Catangerine::Commands::AddSettlementAndRoad.new(@current_player, *vertex, *edge)
  game_manager.play(@command)
end

When(/^I (?:try to )?place a settlement at (#{VERTEX})$/) do |vertex|
  @command = Catangerine::Commands::AddSettlement.new(@current_player, *vertex)
  game_manager.play(@command)
end

When(/^I (?:try to )?place a road at (#{EDGE})$/) do |edge|
  @command = Catangerine::Commands::AddRoad.new(@current_player, *edge)
  game_manager.play(@command)
end

Then(/^it should not succeed$/) do
  expect(@command.success).to be_falsy
end

Then(/^I should receive resource cards from the following tiles:$/) do |table|
  player = game_manager.players.first
  expected_resource_cards = {}
  table.hashes.each do |row|
    coords = coords_to_a(row['tile'])
    tile = board.hex_at(*coords).face
    expected_resource_cards[tile.resource_type] ||= 0
    expected_resource_cards[tile.resource_type] += 1
  end
  expect(player.resource_cards).to eq expected_resource_cards
end
