require 'matrix'

module Year2024
  module Day12
    class Cell
      attr_reader :region_name, :x_coord, :y_coord, :area, :north, :south, :east, :west, :grouped

      def initialize(region_name, x_coord, y_coord)
        @region_name = region_name
        @x_coord = x_coord
        @y_coord = y_coord
        @north = nil
        @south = nil
        @east = nil
        @west = nil
        @grouped = false
        @area = 1
      end

      def add_all_neighbors(garden)
        add_northern_neighbor(garden)
        add_southern_neighbor(garden)
        add_eastern_neighbor(garden)
        add_western_neighbor(garden)

        @grouped = true
      end

      def add_northern_neighbor(garden)
        return unless north.nil?

        @north = northern_neighbor(garden)
        north&.add_southern_neighbor(garden)
      end

      def add_southern_neighbor(garden)
        return unless south.nil?

        @south = southern_neighbor(garden)
        south&.add_northern_neighbor(garden)
      end

      def add_eastern_neighbor(garden)
        return unless east.nil?

        @east = eastern_neighbor(garden)
        east&.add_western_neighbor(garden)
      end

      def add_western_neighbor(garden)
        return unless west.nil?

        @west = western_neighbor(garden)
        west&.add_eastern_neighbor(garden)
      end

      def neighbors
        [north, south, east, west].compact
      end

      def perimeter
        4 - [north, south, east, west].compact.size
      end

      private

      def northern_neighbor(garden)
        to_y = y_coord + 1
        to_x = x_coord
        return nil if to_y >= garden.cells.row_count

        neighbor = garden.cells[to_y, to_x]
        return nil unless neighbor.region_name == region_name

        neighbor
      end

      def southern_neighbor(garden)
        to_y = y_coord - 1
        to_x = x_coord
        return nil if to_y.negative?

        neighbor = garden.cells[to_y, to_x]
        return nil unless neighbor.region_name == region_name

        neighbor
      end

      def eastern_neighbor(garden)
        to_y = y_coord
        to_x = x_coord + 1
        return nil if to_x >= garden.cells.column_count

        neighbor = garden.cells[to_y, to_x]
        return nil unless neighbor.region_name == region_name

        neighbor
      end

      def western_neighbor(garden)
        to_y = y_coord
        to_x = x_coord - 1
        return nil if to_x.negative?

        neighbor = garden.cells[to_y, to_x]
        return nil unless neighbor.region_name == region_name

        neighbor
      end
    end
  end
end
