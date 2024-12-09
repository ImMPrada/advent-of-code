require './lib/year2024/day6/position'

module Year2024
  module Day6
    class Guard
      attr_reader :direction, :position, :visited_positions

      NORTH = 'n'.freeze
      EAST = 'e'.freeze
      SOUTH = 's'.freeze
      WEST = 'w'.freeze
      TO_NORTH = '^'.freeze
      TO_EAST = '>'.freeze
      TO_SOUTH = 'v'.freeze
      TO_WEST = '<'.freeze
      BLOCKED_POSITION = '#'.freeze

      def self.create(symbol, position)
        case symbol
        when TO_NORTH
          new(NORTH, position)
        when TO_EAST
          new(EAST, position)
        when TO_SOUTH
          new(SOUTH, position)
        when TO_WEST
          new(WEST, position)
        end
      end

      def initialize(direction, position)
        @direction = direction
        @position = position
        @visited_positions = [[position, direction]]
      end

      def move(map)
        next_position = next_step_position
        return false unless position_into_map?(next_position, map)

        if next_position_blocked?(next_position, map)
          turn_right
          return move(map)
        end

        move_forward
        true
      end

      private

      def turn_right
        case direction
        when NORTH
          @direction = EAST
        when EAST
          @direction = SOUTH
        when SOUTH
          @direction = WEST
        when WEST
          @direction = NORTH
        end
      end

      def move_forward
        new_position = next_step_position
        @visited_positions << [new_position, direction]
      end

      def next_step_position # rubocop:disable Metrics/AbcSize
        case direction
        when NORTH
          Position.new(position.row - 1, position.col)
        when EAST
          Position.new(position.row, position.col + 1)
        when SOUTH
          Position.new(position.row + 1, position.col)
        when WEST
          Position.new(position.row, position.col - 1)
        end
      end

      def position_into_map?(position, map)
        position.row >= 0 && position.row < map.size &&
          position.col >= 0 && position.col < map[position.row].size
      end

      def next_position_blocked?(position, map)
        map[position.row][position.col] == BLOCKED_POSITION
      end
    end
  end
end
