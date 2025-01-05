require 'matrix'
require_relative 'garden'
require_relative 'loggable'
require_relative 'plot_finder'
require_relative 'perimeter_calculator'

module Year2024
  module Day12
    class Resolver
      include Loggable
      include PlotFinder
      include PerimeterCalculator

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
    end
  end
end
