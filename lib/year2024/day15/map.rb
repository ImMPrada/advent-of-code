require_relative 'cell'
require_relative 'wall'
require_relative 'box'
require_relative 'robot'
require 'matrix'
require_relative 'renderable'

module Year2024
  module Day15
    class Map
      include Renderable

      attr_reader :cells, :starting_robot_cell, :walls_cells, :boxes_cells

      EMPTY_CELL_CHARS = %w[. @].freeze
      ROBOT_CHAR = '@'.freeze

      def initialize(lines)
        @starting_robot_cell = nil
        @walls_cells = []
        @boxes_cells = []

        @cells = Matrix.build(lines.size, lines.first.size) do |row, col|
          char = lines[row][col]
          cell = Cell.new(x_coord: col, y_coord: row, occuppant: EMPTY_CELL_CHARS.include?(char) ? nil : char)
          @starting_robot_cell = cell if char == ROBOT_CHAR
          @walls_cells << cell if char == Cell::WALL
          @boxes_cells << cell if char == Cell::BOX
          cell
        end

        create_walls
        create_boxes
      end

      def [](x_coord, y_coord)
        cells[y_coord, x_coord]
      end

      private

      def create_walls
        walls_cells.each do |cell|
          Wall.new(cell:)
        end
      end

      def create_boxes
        boxes_cells.each do |cell|
          Box.new(cell:)
        end
      end
    end
  end
end
