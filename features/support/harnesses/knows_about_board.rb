module KnowsAboutBoard
  def tile_counts(board)
    Hash[ board.tiles.group_by(&:resource_type).map { |k, v| [k, v.size] } ]
  end

  def chit_counts(board)
    Hash[ board.tiles.group_by(&:chit_number).map { |k, v| [k, v.size] } ]
  end

  def harbor_counts(board)
    Hash[ board.harbors.map(&:harbor_type).group_by(&:to_sym).map { |k, v| [k, v.size] } ]
  end
end

World(KnowsAboutBoard)
