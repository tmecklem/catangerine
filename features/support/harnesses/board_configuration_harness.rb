module BoardConfigurationHarness
  def board_configuration(game_type)
    Catangerine::BoardConfiguration.configuration(game_type)
  end
end
