require 'matrix'
require_relative 'topography'
require_relative 'trail'

module Year2024
  module Day10
    class Resolver
      FILE_PATH = 'lib/year2024/day10/input.txt'.freeze
      OUTPUT_PATH = 'lib/year2024/day10/output.txt'.freeze

      attr_reader :topography, :hiking_trails

      def initialize(path = nil)
        file_path = path || FILE_PATH
        lines = File.readlines(file_path).map(&:chomp)
        @hiking_trails = []
        @topography = Topography.new(lines)
      end

      def run_case1
        build_hiking_trails
        hiking_trails.map do |hiking_trail|
          uniq_trailhead_cells(hiking_trail).count
        end.sum
      end

      def run_case2
        build_hiking_trails
        hiking_trails.map do |hiking_trail|
          trailhead_cells(hiking_trail).count
        end.sum
      end

      def visualize
        topography.render
      end

      def create_file
        File.open(OUTPUT_PATH, 'w') do |file|
          (topography.data.row_count - 1).downto(0) do |row|
            line = topography.data.row(row).to_a.map(&:height).join
            file.puts(line)
          end
        end
      end

      def build_hiking_trails
        topography.lowest_point_heights.each do |starting_trail_cell|
          trail = Trail.new(starting_trail_cell, topography)
          trail.trace_hiking_trail
          hiking_trails << trail
        end
      end

      def uniq_trailhead_cells(hiking_trail)
        hiking_trail.cells.select { |trail_cell| trail_cell.height == Topography::HEIGHT_HEADLINE }.uniq
      end

      def trailhead_cells(hiking_trail)
        hiking_trail.cells.select { |trail_cell| trail_cell.height == Topography::HEIGHT_HEADLINE }
      end
    end
  end
end
