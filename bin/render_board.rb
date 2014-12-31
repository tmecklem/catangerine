#!/usr/bin/env ruby

require 'catangerine'
require 'cairo'
require 'ostruct'
require 'matrix'

width = 200
height = 200

data = nil
stride = nil

module Board2D
  def render(cr, origin)
    # fill background with white
    cr.set_source_color("#fffc")
    cr.paint

    hexes.each_with_index do |(location, hex), i|
      hex.extend(Hex2D)
      hex.render(cr, origin, i)
    end
  end
end

module Hex2D
  def center
    @size = 15
    height = @size*2
    q_basis = Matrix[ [Math.sqrt(3)/2 * height, 0] ]
    r_basis = Matrix[ [(Math.sqrt(3)/2 * height)/2, 3.0/4 * height] ]
    pos = q_basis * location.q + r_basis * location.r
    OpenStruct.new(x: pos[0,0], y: pos[0,1])
  end

  def render(cr, origin, i)
    if self.face
      0.upto(5) do |i|
        angle = 2 * Math::PI / 6 * (i + 0.5)
        vertex = OpenStruct.new(
          x: center[:x] + @size * Math.cos(angle),
          y: center[:y] + @size * Math.sin(angle)
        )
        cr.move_to(vertex.x + origin.x, vertex.y + origin.y) if i==0
        cr.line_to(vertex.x + origin.x, vertex.y + origin.y) unless i==0
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

      cr.set_source_rgb 0.1, 0.1, 0.1

      cr.select_font_face "Purisa", Cairo::FONT_SLANT_NORMAL, Cairo::FONT_WEIGHT_NORMAL
      cr.set_font_size 13

      cr.move_to center.x + origin.x - @size/2, center.y + origin.y + @size/4
      cr.show_text location.name

    end
    cr.target.write_to_png("test#{i}.png")
  end
end

board = Catangerine::BoardGenerator.new(Catangerine::BoardConfiguration.configuration(:expanded)).generate
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
