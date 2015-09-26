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
