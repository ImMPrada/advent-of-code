require_relative 'cell'
require 'matrix'
require_relative 'renderable'
require 'fileutils'

module Year2024
  module Day16
    class Map
      include Renderable

      attr_reader :cells, :starting_cell, :ending_cell

      STARTING_CHAR = 'S'.freeze
      ENDING_CHAR = 'E'.freeze
      WALL_CHAR = '#'.freeze

      def initialize(lines)
        @starting_cell = nil
        @ending_cell = nil

        @cells = Matrix.build(lines.size, lines.first.size) do |row, col|
          char = lines[row][col]
          cell = Cell.new(x_coord: col, y_coord: row, symbol: char == WALL_CHAR ? char : nil)
          @starting_cell = cell if char == STARTING_CHAR
          @ending_cell = cell if char == ENDING_CHAR
          cell
        end
      end

      def [](x_coord, y_coord)
        cells[y_coord, x_coord]
      end
    end
  end
end
