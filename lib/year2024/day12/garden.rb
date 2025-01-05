require 'matrix'
require_relative 'region'
require_relative 'cell'

module Year2024
  module Day12
    class Garden
      attr_reader :cells, :regions_names, :regions, :file_lines

      def initialize(file_lines)
        @file_lines = file_lines
        @regions = []
        @regions_names = []
        build_cells
      end

      def build_regions
        @regions = regions_names.map do |name|
          region = Region.new(name)
          region.group_cells(self)
          region
        end
      end

      def regions_prices
        prices = {}
        regions.each do |region|
          prices[region.name] = region.price
        end
        prices
      end

      private

      def build_cells
        rows = file_lines.length
        cols = file_lines.first.length
        @regions_names = []

        @cells = Matrix.build(rows, cols) do |y, x|
          region_name = file_lines[y][x]
          cell = Cell.new(region_name, x, y)
          @regions_names << region_name
          cell
        end

        @regions_names.uniq!
      end
    end
  end
end
