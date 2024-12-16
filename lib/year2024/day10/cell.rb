require 'matrix'

module Year2024
  module Day10
    class Cell
      attr_reader :height, :x_coord, :y_coord

      def initialize(height, x_coord, y_coord)
        @height = height
        @x_coord = x_coord
        @y_coord = y_coord
      end

      def northern_neighbor(topography)
        to_y = y_coord + 1
        to_x = x_coord
        return nil if to_y >= topography.data.row_count

        topography.data[to_y, to_x]
      end

      def southern_neighbor(topography)
        to_y = y_coord - 1
        to_x = x_coord
        return nil if to_y.negative?

        topography.data[to_y, to_x]
      end

      def eastern_neighbor(topography)
        to_y = y_coord
        to_x = x_coord + 1
        return nil if to_x >= topography.data.column_count

        topography.data[to_y, to_x]
      end

      def western_neighbor(topography)
        to_y = y_coord
        to_x = x_coord - 1
        return nil if to_x.negative?

        topography.data[to_y, to_x]
      end
    end
  end
end
