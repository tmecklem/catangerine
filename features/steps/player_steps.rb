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

  expected_resource_cards.each do |resource_type, count|
    expect(player.resource_cards[resource_type]).to eq count
  end
end
