module KnowsAboutBoardConfiguration
  def board_configuration(game_type)
    Catangerine::BoardConfiguration.configuration(game_type)
  end
end

World(KnowsAboutBoardConfiguration)
