module KnowsAboutGameManager
  attr_accessor :game_manager

  def create_game_manager(player_count, number_of_roads: 15)
    Catangerine::GameManager.new(player_count: player_count.to_i, number_of_roads: number_of_roads)
  end
end

World(KnowsAboutGameManager)
