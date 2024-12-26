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
        @paths = []

        @map = Map.new(lines)
        @reindeer = Reindeer.new
      end

      def run_case1(visualize: false)
        price = reindeer.find_shortest_paths_price(map)
        puts "Found #{reindeer.best_paths.size} optimal paths with price #{price}"
        @paths = collect_paths
        map.render('all_paths', paths) if paths.any? && visualize

        price
      end

      def run_case2(visualize: false)
        run_case1(visualize:) if paths.empty?

        paths.each do |path|
          path.each do |x, y, _dir, _|
            map[x, y].seat = true
          end
        end

        count = 0

        map.cells.each do |cell|
          count += 1 if cell.seat
        end

        count
      end

      private

      attr_accessor :paths

      def collect_paths
        reindeer.best_paths.size.times.map do |index|
          path = reindeer.visualize_path(index)
          next unless path

          puts "\nPath #{index + 1}:"
          puts "Steps: #{path.size}"
          puts "Path: #{path.map { |x, y, dir, _| "(#{x},#{y},#{dir})" }.join(' -> ')}"
          path
        end.compact
      end
    end
  end
end
