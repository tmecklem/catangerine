Then(/^it should be (#{PLAYER})'s turn$/) do |player|
  expect(game_manager.current_player).to eq player
end

When(/^(#{PLAYER}) (?:tries to place|places)? a settlement at (#{VERTEX}) and a road at (#{EDGE})$/) do |player, vertex, edge|
  @command = Catangerine::Commands::AddSettlementAndRoad.new(player, settlement_location: vertex, road_location: edge)
  game_manager.play(@command)
end

When(/^(#{PLAYER}) (has cards and )?(?:tries to place|places)? a settlement at (#{VERTEX})$/) do |player, has_cards, vertex|
  if has_cards
    player.acquire_cards(:brick, 1)
    player.acquire_cards(:lumber, 1)
    player.acquire_cards(:wool, 1)
    player.acquire_cards(:grain, 1)
  end
  @command = Catangerine::Commands::AddSettlement.new(player, settlement_location: vertex)
  game_manager.play(@command)
  puts @command.errors unless @command.success
end

When(/^(#{PLAYER}) (has cards and )?(?:tries to place|places)? a road at (#{EDGE})$/) do |player, has_cards, edge|
  if has_cards
    player.acquire_cards(:brick, 1)
    player.acquire_cards(:lumber, 1)
  end
  @command = Catangerine::Commands::AddRoad.new(player, road_location: edge)
  game_manager.play(@command)
  puts @command.errors unless @command.success
end

Then(/^it should not succeed$/) do
  expect(@command.success).to be_falsy
end

Then(/^(#{PLAYER}) should have the longest road card$/) do |player|
  expect(game_manager.player_with_longest_road_card).to eq player
end

Then(/^(#{PLAYER}) should receive the longest road card$/) do |player|
  expect(game_manager.player_with_longest_road_card).to eq player
end

Then(/^(#{PLAYER}) should not receive the longest road card$/) do |player|
  expect(game_manager.player_with_longest_road_card).not_to eq player
end
