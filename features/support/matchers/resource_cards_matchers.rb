require 'rspec/matchers'
require 'rspec/expectations'

RSpec::Matchers.define :have_resource_cards do |expected_resource_cards|
  match do |player|
    player.resource_cards.merge(expected_resource_cards) == player.resource_cards
  end
end
