#!/usr/bin/env ruby

require 'catangerine'
require 'cairo'
require 'ostruct'
require 'matrix'
require_relative '../lib/catangerine/render'

width = 600
height = 600

data = nil
stride = nil

module Board2D
  def render(cr, origin)
    cr.set_source_color("#fffc")
    cr.paint

    hexes.each_with_index do |(location, hex), i|
      hex.extend(Catangerine::Hex2d)
      hex.render(cr, origin, 30, i)
    end
  end
end


game_manager = Catangerine::GameManager.new(player_count: 4).start_game
board = game_manager.board
player1 = game_manager.players[0]
add_command = Catangerine::Commands::AddSettlementAndRoad.new(player1,
  settlement_location: Catangerine::Location.new('A', 't'),
  road_location: Catangerine::Location.new('A', 'nw')
)
game_manager.play(add_command)

board.extend(Board2D)
Cairo::ImageSurface.new(width, height) do |surface|
  cr = Cairo::Context.new(surface)
  origin = OpenStruct.new(x: width/2, y: height/2)
  board.render(cr, origin)


  cr.target.write_to_png("test.png")

  data = cr.target.data
  stride = cr.target.stride
end

Cairo::ImageSurface.new(data, :argb32, width, height, stride) do |surface|
  surface.write_to_png("test-renew.png")
end
