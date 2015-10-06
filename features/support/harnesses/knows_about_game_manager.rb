module KnowsAboutGameManager
  attr_accessor :game_manager

  def create_game_manager(player_count)
    Catangerine::GameManager.new(player_count: player_count.to_i, number_of_roads: @number_of_roads || 15, number_of_settlements: @number_of_settlements || 5)
  end
end

World(KnowsAboutGameManager)
