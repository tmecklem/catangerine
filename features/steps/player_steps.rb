Given(/^(#{PLAYER}) has the following cards:$/) do |player, card_table|
  card_table.hashes.each do |card_row|
    player.acquire_cards(card_row['type'].to_sym, card_row['count'].to_i)
  end
end

Then(/^(#{PLAYER}) should have the following cards:$/) do |player, card_table|
  card_table.hashes.each do |card_row|
    expect(player.resource_cards[card_row['type'].to_sym]).to eq(card_row['count'].to_i)
  end
end

Then(/^(#{PLAYER}) should receive resource cards from the following tiles:$/) do |player, table|
  expected_resource_cards = {}
  table.hashes.map do |row|
    location = Catangerine::Location.new(row['tile'])
    tile = board.hex_at(location).face
    next unless tile.resource_type # DESERT gives no resources!
    expected_resource_cards[tile.resource_type] ||= 0
    expected_resource_cards[tile.resource_type] += 1
  end

  expect(player).to have_resource_cards(expected_resource_cards)
end

When(/^(#{PLAYER}) rolls the dice$/) do |player|
  @dice_command = Catangerine::Commands::Dice.new(player)
  game_manager.play(@dice_command)
end

Then(/^(#{PLAYER}) should get (\d+) resource card for each terrain with a matching number$/) do |player, _number_of_cards|
  tiles = game_manager.board.tiles_with_chit(@dice_command.dice_value)
  tiles_by_resource = tiles.group_by(&:resource_type)
  expected_resource_cards = tiles_by_resource.each_with_object({}) { |(resource_type, tiles_of_terrain), acc|
    acc[resource_type] = tiles_of_terrain.size
  }

  expect(player).to have_resource_cards(expected_resource_cards)
end
