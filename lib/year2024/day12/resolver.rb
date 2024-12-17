require 'matrix'
require_relative 'garden'

module Year2024
  module Day12
    class Resolver
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
        puts 'not implemented'
      end

      def visualize
        garden.render
      end
    end
  end
end
