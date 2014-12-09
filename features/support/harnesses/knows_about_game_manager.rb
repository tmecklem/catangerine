module KnowsAboutGameManager
  attr_accessor :game_manager

  def create_game_manager(player_count)
    Catangerine::GameManager.new(player_count: player_count.to_i)
  end
end

World(KnowsAboutGameManager)
