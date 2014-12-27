#!/usr/bin/env ruby

require 'catangerine'
require 'cairo'

width = 200
height = 200

data = nil
stride = nil

module Board2D
  def render(cr)
    # fill background with white
    cr.set_source_color("#fffc")
    cr.paint

    tiles.each do |tile|
      tile.extend(Tile2D)
      tile.render(cr)
    end
  end
end

module Tile2D
  def center
    @size = 15
    x = @size * Math.sqrt(3) * (position.location.q + position.location.r/2)
    y = @size * 3/2 * position.location.r
    { x: x, y: y }
  end

  def render(cr)
    0.upto(5) do |i|
      angle = 2 * Math::PI / 6 * (i + 0.5)
      x_i = center[:x] + @size * Math.cos(angle)
      y_i = center[:y] + @size * Math.sin(angle)
      cr.move_to(x_i, y_i) if i==0
      cr.line_to(x_i, y_i) unless i==0
    end
    cr.close_path
    # create shape
    #cr.move_to(50, 50)
    #cr.curve_to(100, 25, 100, 75, 150, 50)
    #cr.line_to(150, 150)
    #cr.line_to(50, 150)
    #cr.close_path

    #cr.set_source_color(:black)
    #cr.fill_preserve
    cr.set_source_color(:red)
    cr.set_line_join(Cairo::LINE_JOIN_MITER)
    cr.set_line_width(1)
    cr.stroke

  end
end

board = Catangerine::BoardGenerator.new(Catangerine::BoardConfiguration.configuration(:standard)).generate
board.extend(Board2D)

Cairo::ImageSurface.new(width, height) do |surface|
  cr = Cairo::Context.new(surface)
  board.render(cr)


  cr.target.write_to_png("test.png")

  data = cr.target.data
  stride = cr.target.stride
end

Cairo::ImageSurface.new(data, :argb32, width, height, stride) do |surface|
  surface.write_to_png("test-renew.png")
end
