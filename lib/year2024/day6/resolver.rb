require './lib/year2024/day6/position'
require './lib/year2024/day6/guard'
require './lib/year2024/day6/guard_not_found_error'

module Year2024
  module Day6
    class Resolver
      FILE_PATH = 'lib/year2024/day6/input.txt'.freeze
      DIRECTIONS = [[-1, 0], [0, 1], [1, 0], [0, -1]].freeze

      attr_reader :guard, :map, :grid, :height, :width

      def initialize(path = nil)
        @file_path = path || FILE_PATH
        @map = File.readlines(file_path).map(&:chomp)
        @grid = map.map(&:chars)
        @height = grid.size
        @width = grid[0].size
        @guard_position = find_guard_position
      end

      def run_case1
        create_guard
        guard.find_exit(map)
        guard.visited_positions.map { |position| [position.row, position.col] }.uniq.size
      end

      def run_case2
        find_loop_positions.size
      end

      private

      attr_reader :file_path, :guard_position

      def find_loop_positions
        visited = find_original_path
        loops = Set.new

        visited.each do |pos|
          next if pos == guard_position # Skip guard's starting position

          test_grid = grid.map(&:dup)
          loops.add(pos) if creates_loop?(test_grid, pos)
        end

        loops
      end

      def find_original_path
        i, j = guard_position
        direction_index = 0
        visited = Set.new

        loop do
          visited.add([i, j])

          next_i = i + DIRECTIONS[direction_index][0]
          next_j = j + DIRECTIONS[direction_index][1]

          break unless in_bounds?(next_i, next_j)

          if grid[next_i][next_j] == '#'
            direction_index = (direction_index + 1) % 4
          else
            i = next_i
            j = next_j
          end
        end

        visited
      end

      def creates_loop?(test_grid, pos)
        return false if test_grid[pos[0]][pos[1]] == '#'

        test_grid[pos[0]][pos[1]] = '#'
        guard_position_i, guard_position_j = guard_position
        direction_index = 0
        seen = Set.new

        check_loop(guard_position_i, guard_position_j, direction_index, seen, test_grid, pos)
      end

      def check_loop(guard_position_i, guard_position_j, direction_index, seen, test_grid, pos)
        loop do
          state = [guard_position_i, guard_position_j, direction_index]

          if seen.include?(state)
            test_grid[pos[0]][pos[1]] = '.'
            return true
          end

          seen.add(state)
          next_i, next_j, direction_index = compute_next_indexes(guard_position_i, guard_position_j, direction_index)

          unless in_bounds?(next_i, next_j)
            test_grid[pos[0]][pos[1]] = '.'
            return false
          end

          if test_grid[next_i][next_j] == '#'
            direction_index = (direction_index + 1) % 4
          else
            guard_position_i = next_i
            guard_position_j = next_j
          end

          [guard_position_i, guard_position_j, direction_index]
        end
      end

      def compute_next_indexes(guard_position_i, guard_position_j, direction_index)
        next_i = guard_position_i + DIRECTIONS[direction_index][0]
        next_j = guard_position_j + DIRECTIONS[direction_index][1]

        [next_i, next_j, direction_index]
      end

      def in_bounds?(i_coord, j_coord)
        i_coord.between?(0, height - 1) && j_coord.between?(0, width - 1)
      end

      def find_guard_position
        grid.each_with_index do |row, i|
          row.each_with_index do |cell, j|
            return [i, j] if cell == '^'
          end
        end
        raise GuardNotFoundError
      end

      def create_guard
        row_index, column_index = guard_position
        guard_symbol = map[row_index][column_index]
        @guard = Guard.create(guard_symbol, [row_index, column_index])
      end
    end
  end
end
