require_relative 'cell'
require 'matrix'

module Year2024
  module Day14
    class Map
      attr_reader :cells

      def initialize(width, height)
        @cells = Matrix.build(width, height) do |row, col|
          Cell.new(x_coord: col, y_coord: row)
        end
      end

      def [](x_coord, y_coord)
        row = y_coord < row_count ? y_coord :  y_coord - row_count
        col = x_coord < column_count ? x_coord : x_coord - column_count
        cells[row, col]
      end

      private

      def row_count
        cells.row_count
      end

      def column_count
        cells.column_count
      end
    end
  end
end
