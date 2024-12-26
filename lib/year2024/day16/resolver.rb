require_relative 'map'
require_relative 'reindeer'

module Year2024
  module Day16
    class Resolver
      FILE_PATH = 'lib/year2024/day16/input.txt'.freeze

      attr_reader :map, :reindeer

      def initialize(path = nil)
        file_path = path || FILE_PATH
        lines = File.readlines(file_path).map(&:chomp)

        @map = Map.new(lines)
        @reindeer = Reindeer.new
      end

      def run_case1
        price = reindeer.find_shortest_path(map)
        path = reindeer.visualize_path
        map.render('solution', path) if path

        price
      end
    end
  end
end
