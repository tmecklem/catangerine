module KnowsAboutBoard
  def board
    game_manager.board
  end

  def tile_counts
    Hash[ board.tiles.group_by(&:resource_type).map { |k, v| [k, v.size] } ]
  end

  def chit_counts
    Hash[ board.tiles.group_by(&:chit_number).map { |k, v| [k, v.size] } ]
  end

  def harbor_counts
    Hash[ board.harbors.map(&:harbor_type).group_by(&:to_sym).map { |k, v| [k, v.size] } ]
  end
end

World(KnowsAboutBoard)
