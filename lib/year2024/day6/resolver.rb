require './lib/year2024/day6/position'
require './lib/year2024/day6/guard'
require './lib/year2024/day6/guard_not_found_error'

module Year2024
  module Day6
    class Resolver
      FILE_PATH = 'lib/year2024/day6/input.txt'.freeze

      attr_reader :guard, :map

      def initialize(path = nil)
        @file_path = path || FILE_PATH
        @map = build_map
      end

      def run_case1
        create_guard
        guard.find_exit(map)
        guard.visited_positions.map { |position| [position.row, position.col] }.uniq.size
      end

      def run_case2
        puts 'not ready'
      end

      private

      attr_reader :file_path

      def create_guard
        row_index, column_index = find_guard_position
        guard_symbol = map[row_index][column_index]
        @guard = Guard.create(guard_symbol, [row_index, column_index])
      end

      def find_guard_position
        map.each_with_index do |row, row_index|
          column_index = row.index(Guard::TO_NORTH) ||
                         row.index(Guard::TO_EAST) ||
                         row.index(Guard::TO_SOUTH) ||
                         row.index(Guard::TO_WEST)
          return [row_index, column_index] if column_index
        end

        raise GuardNotFoundError
      end

      def lock_position(position)
        # raise GuardPositionError if map[position.row][position.col] == Guard::ENABLED_POSITION

        map[position.row][position.col] = Guard::BLOCKED_POSITION
      end

      def build_map
        file_content = File.read(file_path)
        file_content.split("\n")
      end
    end
  end
end
