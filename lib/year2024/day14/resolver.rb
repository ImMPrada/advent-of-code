require_relative 'map'
require_relative 'robot'
require_relative 'velocity'
require_relative 'renderable'
require_relative 'statisticable'

module Year2024
  module Day14
    class Resolver # rubocop:disable Metrics/ClassLength
      FILE_PATH = 'lib/year2024/day14/input.txt'.freeze
      WIDTH = 101
      HEIGHT = 103
      POSITIVE_HISTOGRAM_FILE = './visualizations/day14/density_positive_skewness_histograms.html'.freeze
      NEGATIVE_HISTOGRAM_FILE = './visualizations/day14/density_negative_skewness_histograms.html'.freeze

      DEFAULT_DENSITY_ARRANGEMENT = [
        [1, 0, 0, 0, 0, 0, 1],
        [0, 3, 0, 0, 0, 3, 0],
        [0, 0, 8, 8, 8, 0, 0],
        [0, 0, 8, 1, 8, 0, 0],
        [0, 0, 8, 8, 8, 0, 0],
        [0, 3, 0, 0, 0, 3, 0],
        [1, 0, 0, 0, 0, 0, 1]
      ].freeze

      include Renderable
      include Statisticable
      attr_reader :map, :robots

      def initialize(width = WIDTH, height = HEIGHT, path = nil)
        @map = Map.new(width, height)
        @robots = []

        file_path = path || FILE_PATH
        lines = File.readlines(file_path).map(&:chomp)

        add_robots(lines)
      end

      def run_case1(seconds, visualize: false)
        seconds.times do |count|
          puts "count: #{count}"
          robots.each { |robot| robot.move(map) }
          map.render(count, title: "map_visualization_#{count}") if visualize
        end

        quadrants = build_quadrants
        sum_of_occupants = quadrants.map do |quadrant|
          sum = 0
          quadrant.each { |cell| sum += cell.occupying.size }
          sum
        end

        sum_of_occupants.reduce(:*)
      end

      def run_case2(seconds, visualize: false, density_arrangement: DEFAULT_DENSITY_ARRANGEMENT)
        densities = []

        seconds.times do |count|
          puts "count: #{count + 1}"
          robots.each { |robot| robot.move(map) }
          cells_density = map.cells_density(density_arrangement)
          skewness = map.skewness(cells_density)
          densities << { skewness:, density: cells_density, time: count + 1 }
          map.render(count, title: "map_visualization_#{count}") if visualize
        end

        sorted_densities = densities.sort_by { |density| density[:skewness] }

        render_skewness_histograms(sorted_densities)
        sorted_densities
      end

      private

      def add_robots(lines)
        lines.each do |line|
          p, v = line.split(' ')

          cell = map_cell(p)
          velocity = velocity(v)
          robot = Robot.new(cell:, velocity:)
          robots << robot
        end
      end

      def velocity(v_string)
        vx, vy = v_string.split('=').last.split(',').map(&:to_i)
        Velocity.new(x_component: vx, y_component: vy)
      end

      def map_cell(p_string)
        x, y = p_string.split('=').last.split(',').map(&:to_i)
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

      def render_skewness_histograms(sorted_densities)
        render_histograms(sorted_densities[-5..], page_title: 'positive skewness', file_name: POSITIVE_HISTOGRAM_FILE)
        render_histograms(sorted_densities[0..4], page_title: 'negative skewness', file_name: NEGATIVE_HISTOGRAM_FILE)
      end
    end
  end
end
