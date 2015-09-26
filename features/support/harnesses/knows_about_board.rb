module KnowsAboutBoard
  def board
    game_manager.board
  end

  def tile_counts
    Hash[board.tiles.group_by(&:terrain).map { |k, v| [k, v.size] }]
  end

  def chit_counts
    Hash[board.tiles.group_by(&:chit_number).map { |k, v| [k, v.size] }]
  end

  def harbor_counts
    Hash[board.harbors.map(&:harbor_type).group_by(&:to_sym).map { |k, v| [k, v.size] }]
  end

  def coords_to_a(coords)
    arr = coords.split(',')
    arr.map.each_with_index do |val, i|
      i < 2 ? val.to_i : val.to_sym
    end
  end
end

World(KnowsAboutBoard)
