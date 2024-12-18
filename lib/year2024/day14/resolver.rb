require_relative 'map'
require_relative 'robot'
require_relative 'velocity'

module Year2024
  module Day14
    class Resolver
      FILE_PATH = 'lib/year2024/day14/input.txt'.freeze
      WIDTH = 101
      HEIGHT = 103

      attr_reader :map, :robots

      def initialize(width = WIDTH, height = HEIGHT, path = nil)
        @map = Map.new(width, height)
        @robots = []

        file_path = path || FILE_PATH
        lines = File.readlines(file_path).map(&:chomp)

        add_robots(lines)
      end

      def run_case1(seconds, visualize: false)
        visualize('time_0') if visualize

        seconds.times do |count|
          robots.each { |robot| robot.move(map) }
          visualize("time_#{count + 1}") if visualize
        end

        quadrants = build_quadrants
        sum_of_occupants = quadrants.map do |quadrant|
          sum = 0
          quadrant.each { |cell| sum += cell.occupying.size }
          sum
        end

        sum_of_occupants.reduce(:*)
      end

      def visualize(title)
        map.render(title)
      end

      private

      def add_robots(lines)
        lines.each do |line|
          p, v = line.split(' ')

          cell = map_cell(p)
          puts "cell: #{cell.to_a}"
          velocity = velocity(v)
          puts "velocity: #{velocity.to_a}"
          robot = Robot.new(cell:, velocity:)
          robots << robot
        end
      end

      def velocity(v_string)
        vx, vy = v_string.split('=').last.split(',').map(&:to_i)
        puts "vx: #{vx}, vy: #{vy}"
        Velocity.new(x_component: vx, y_component: vy)
      end

      def map_cell(p)
        x, y = p.split('=').last.split(',').map(&:to_i)
        puts "x: #{x}, y: #{y}"
        map[x, y]
      end

      def build_quadrants
        quadrants_columns_index_separator = map.cells.column_count / 2
        quadrants_rows_index_separator = map.cells.row_count / 2

        quadrants = []
        quadrants << build_first_quadrant(quadrants_rows_index_separator, quadrants_columns_index_separator)
        quadrants << build_second_quadrant(quadrants_rows_index_separator, quadrants_columns_index_separator)
        quadrants << build_third_quadrant(quadrants_rows_index_separator, quadrants_columns_index_separator)
        quadrants << build_fourth_quadrant(quadrants_rows_index_separator, quadrants_columns_index_separator)

        quadrants
      end

      def build_first_quadrant(quadrants_rows_index_separator, quadrants_columns_index_separator)
        map.cells.minor(
          0...quadrants_rows_index_separator,
          0...quadrants_columns_index_separator
        )
      end

      def build_second_quadrant(quadrants_rows_index_separator, quadrants_columns_index_separator)
        map.cells.minor(
          0...quadrants_rows_index_separator,
          quadrants_columns_index_separator + 1...map.cells.column_count
        )
      end

      def build_third_quadrant(quadrants_rows_index_separator, quadrants_columns_index_separator)
        map.cells.minor(
          quadrants_rows_index_separator + 1...map.cells.row_count,
          0...quadrants_columns_index_separator
        )
      end

      def build_fourth_quadrant(quadrants_rows_index_separator, quadrants_columns_index_separator)
        map.cells.minor(
          quadrants_rows_index_separator + 1...map.cells.row_count,
          quadrants_columns_index_separator + 1...map.cells.column_count
        )
      end
    end
  end
end
