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

      def run_case1(visualize: false)
        map.render('initial') if visualize
        move_robot(visualize)
        map.render('final') if visualize

        sum_boxes_gps
      end

      def run_case2
        puts 'TODO'
      end

      private

      def move_robot(visualize)
        directions.each_with_index do |direction, index|
          puts "Moving #{direction}"
          robot.move(map, direction)
          map.render("step_#{index + 1}") if ((index + 1) % 10).zero? && visualize
        end
      end

      def sum_boxes_gps
        boxes_cells = map.cells.select { |cell| cell.occupant&.symbol == Cell::BOX }
        boxes_gps = boxes_cells.map { |cell| cell.x + 100 * cell.y }
        boxes_gps.sum
      end
    end
  end
end
