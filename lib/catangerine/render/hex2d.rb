#!/usr/bin/env ruby

require 'catangerine'
require 'cairo'
require 'ostruct'
require 'matrix'

module Catangerine
  module Hex2d
    TILE_COLORS = {
      hills: '#9b6038ff',
      pasture: '#6b9847ff',
      mountains: '#93857fff',
      fields: '#e6b651ff',
      forest: '#36492bff',
      desert: '#c3a167ff'
    }

    attr_accessor :size, :cr, :origin, :i

    def center
      @center ||= OpenStruct.new(x: position[0, 0], y: position[0, 1])
    end

    def render(cr, origin, size, i)
      @cr = cr
      @origin = origin
      @size = size
      @i = i
      render_hex(cr, origin)
      # edges.each do |edge|
      #   render_edge(edge, cr, origin)
      # end
    end

    def render_hex(cr, origin)
      return unless on_board?
      (0..5).each do |index|
        angle = 2 * Math::PI / 6 * (index + 0.5)
        vertex = OpenStruct.new(
          x: center[:x] + size * Math.cos(angle),
          y: center[:y] + size * Math.sin(angle)
        )
        cr.move_to(vertex.x + origin.x, vertex.y + origin.y) if index == 0
        cr.line_to(vertex.x + origin.x, vertex.y + origin.y) unless index == 0
      end

      cr.close_path
      cr.set_source_color(tile_color)
      cr.fill_preserve
      cr.set_source_color(:gray)
      cr.set_line_join(Cairo::LINE_JOIN_MITER)
      cr.set_line_width(1)
      cr.stroke

      cr.set_source_rgb 0.1, 0.1, 0.1
      draw_face(cr)
    end

    def on_board?
      face
    end

    def tile_color
      TILE_COLORS[face.terrain]
    end

    def render_edge(edge)

    end

    def q_basis
      Matrix[[Math.sqrt(3) / 2 * height, 0]]
    end

    def r_basis
      Matrix[[(Math.sqrt(3) / 2 * height) / 2, 3.0 / 4 * height]]
    end

    def position
      q_basis * location.q + r_basis * location.r
    end

    def height
      size * 2
    end

    def draw_face(cr)
      cr.select_font_face "Purisa", Cairo::FONT_SLANT_NORMAL, Cairo::FONT_WEIGHT_NORMAL
      cr.set_font_size 13
      cr.move_to(*face_text_position)
      cr.show_text "#{location.name} #{face.terrain[0..1]}"
    end

    def face_text_position
      [center.x + origin.x - size / 2, center.y + origin.y + size / 4]
    end
  end
end
