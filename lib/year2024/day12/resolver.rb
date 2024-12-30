require 'matrix'
require_relative 'garden'
require_relative 'loggable'

module Year2024
  module Day12
    class Resolver
      include Loggable

      FILE_PATH = 'lib/year2024/day12/input.txt'.freeze

      attr_reader :garden

      def initialize(path = nil)
        file_path = path || FILE_PATH
        lines = File.readlines(file_path).map(&:chomp)
        @garden = Garden.new(lines)
      end

      def run_case1
        garden.build_regions
        prices = garden.regions_prices
        prices.values.sum
      end

      def run_case2
        log_start_search
        plots = find_plots(garden.file_lines)

        log_calculation_start
        total = calculate_total_price(plots)

        log_total_price(total)
        total
      end

      private

      def calculate_total_price(plots)
        total = 0
        plots.each do |char, plot|
          perimeter = calculate_perimeter(plot)
          area = plot.size
          price = perimeter * area
          total += price
          log_region_price(char, area, perimeter, price)
        end
        total
      end

      def find_plots(grid)
        n = grid.size
        seen = Set.new
        plots = []

        n.times do |i|
          n.times do |j|
            next if seen.include?([i, j])

            find_plot(grid, i, j, seen, plots)
          end
        end

        plots
      end

      def find_plot(grid, start_i, start_j, seen, plots)
        stack = [[start_i, start_j]]
        plots << [grid[start_i][start_j], []]

        process_plot_stack(grid, stack, seen, plots)
      end

      def process_plot_stack(grid, stack, seen, plots)
        while stack.any?
          log_stack_progress(stack.size)
          current_i, current_j = stack.pop
          next if seen.include?([current_i, current_j])
          next unless valid_cell?(grid, current_i, current_j)
          next unless same_region?(grid, current_i, current_j, plots.last[0])

          add_cell_to_plot(current_i, current_j, seen, plots)
          add_neighbors_to_stack(grid, current_i, current_j, stack)
        end
      end

      def valid_cell?(grid, i, j)
        in_grid?(i, j, grid.size)
      end

      def same_region?(grid, i, j, region_char)
        grid[i][j] == region_char
      end

      def add_cell_to_plot(i, j, seen, plots)
        seen.add([i, j])
        plots.last[1] << [i, j]
        log_plot_found(plots.last[0], plots.last[1].size) if (plots.last[1].size % 10).zero?
      end

      def add_neighbors_to_stack(_grid, i, j, stack)
        DIRECTIONS.each do |di, dj|
          stack << [i + di, j + dj]
        end
      end

      DIRECTIONS = [[-1, 0], [0, 1], [1, 0], [0, -1]].freeze

      def calculate_perimeter(plot)
        plot_set = Set.new(plot)
        boundaries = find_plot_boundaries(plot)
        count_corners(plot_set, boundaries)
      end

      def find_plot_boundaries(plot)
        mini, maxi = plot.map(&:first).minmax
        minj, maxj = plot.map(&:last).minmax
        { min_i: mini, max_i: maxi, min_j: minj, max_j: maxj }
      end

      def count_corners(plot_set, boundaries)
        corners = 0
        (boundaries[:min_i] - 1..boundaries[:max_i]).each do |i|
          (boundaries[:min_j] - 1..boundaries[:max_j]).each do |j|
            corner_count = evaluate_corner(plot_set, i, j)
            corners += corner_count
            log_corner_found(i, j, corners) if corner_count.positive?
          end
        end
        corners
      end

      def evaluate_corner(plot_set, i, j)
        coords = generate_corner_coords(i, j)
        result = test_coords(coords, plot_set)
        count_corner_type(result)
      end

      def generate_corner_coords(i, j)
        [
          [i, j],      # top-left
          [i, j + 1],  # top-right
          [i + 1, j],  # bottom-left
          [i + 1, j + 1] # bottom-right
        ]
      end

      def count_corner_type(result)
        return 1 if single_corner?(result)
        return 2 if double_corner?(result)

        0
      end

      def single_corner?(result)
        [
          [1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1],
          [1, 1, 1, 0], [1, 1, 0, 1], [1, 0, 1, 1], [0, 1, 1, 1]
        ].include?(result)
      end

      def double_corner?(result)
        [[1, 0, 0, 1], [0, 1, 1, 0]].include?(result)
      end

      def test_coords(coords, plot_set)
        coords.map { |i, j| plot_set.include?([i, j]) ? 1 : 0 }
      end

      def in_grid?(i_coord, j_coord, n)
        (i_coord >= 0 && i_coord < n) && (j_coord >= 0 && j_coord < n)
      end
    end
  end
end
