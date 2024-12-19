require_relative 'map'
require_relative 'robot'

module Year2024
  module Day15
    class Resolver
      FILE_PATH = 'lib/year2024/day15/input.txt'.freeze

      attr_reader :map, :directions, :robot

      def initialize(path = nil)
        file_path = path || FILE_PATH
        lines = File.readlines(file_path).map(&:chomp)

        map_lines = lines.take_while { |line| !line.empty? }
        directions_lines = lines[map_lines.size + 1..]
        @map = Map.new(map_lines)
        @directions = directions_lines.join.chars
        @robot = Robot.new(cell: @map.starting_robot_cell)
      end

      def run_case1
        puts 'TODO'
      end
    end
  end
end
