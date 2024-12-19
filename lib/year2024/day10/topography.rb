require 'matrix'
require_relative 'cell'

module Year2024
  module Day10
    class Topography
      attr_reader :data, :lowest_point_heights

      HEIGHT_HEADLINE = 9.0
      LOWEST_HEIGHT = 0

      def initialize(file_lines)
        @file_lines = file_lines
        build_data
      end

      private

      attr_reader :file_lines

      def build_data
        rows = file_lines.length
        cols = file_lines.first.length
        lowest_point = LOWEST_HEIGHT
        @lowest_point_heights = []

        @data = Matrix.build(rows, cols) do |y, x|
          height = file_lines[y][x].to_i
          if height < lowest_point
            @lowest_point_heights = []
            lowest_point = height
          end

          cell = Cell.new(height, x, y)
          @lowest_point_heights << cell if height == lowest_point
          cell
        end
      end
    end
  end
end
