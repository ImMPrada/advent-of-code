require './lib/year2024/day6/position'
require './lib/year2024/day6/guard'

module Year2024
  module Day6
    class Resolver
      FILE_PATH = 'lib/year2024/day6/input.txt'.freeze

      attr_reader :guard, :map

      def initialize(path = nil)
        file_content = File.read(path || FILE_PATH)
        @map = file_content.split("\n")

        create_guard
      end

      def run_case1
        guard.find_exit(map)
        guard.visited_positions.size
      end

      private

      def create_guard
        guard_position = find_guard_position
        guard_symbol = map[guard_position.row][guard_position.col]
        @guard = Guard.create(guard_symbol, guard_position)
      end

      def find_guard_position
        map.each_with_index do |row, row_index|
          column_index = row.index(Guard::TO_NORTH) ||
                         row.index(Guard::TO_EAST) ||
                         row.index(Guard::TO_SOUTH) ||
                         row.index(Guard::TO_WEST)
          return Position.new(row_index, column_index) if column_index
        end
      end
    end
  end
end
