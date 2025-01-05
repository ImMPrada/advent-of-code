require './lib/year2024/day6/position'
require './lib/year2024/day6/loop_error'

module Year2024
  module Day6
    class Guard
      attr_reader :position
      attr_accessor :visited_positions

      NORTH = 'n'.freeze
      EAST = 'e'.freeze
      SOUTH = 's'.freeze
      WEST = 'w'.freeze
      TO_NORTH = '^'.freeze
      TO_EAST = '>'.freeze
      TO_SOUTH = 'v'.freeze
      TO_WEST = '<'.freeze
      BLOCKED_POSITION = '#'.freeze
      ENABLED_POSITION = '.'.freeze

      def self.create(symbol, position)
        case symbol
        when TO_NORTH
          new(Position.new(position[0], position[1], NORTH))
        when TO_EAST
          new(Position.new(position[0], position[1], EAST))
        when TO_SOUTH
          new(Position.new(position[0], position[1], SOUTH))
        when TO_WEST
          new(Position.new(position[0], position[1], WEST))
        end
      end

      def initialize(position)
        @position = position
        @visited_positions = [position]
      end

      def move(map)
        next_position = next_step_position
        return false unless position_into_map?(next_position, map)

        if locked_position?(next_position, map)
          puts "locked position: #{next_position.to_a}"
          puts 'turn right'
          turn_right
          return move(map)
        end

        move_forward
        true
      end

      def find_exit(map)
        puts 'tea find_exit'
        can_move = true

        while can_move
          puts "can_move: #{position.to_a}"
          can_move = move(map)
        end
      end

      def next_step_position
        new_positions = {
          NORTH => move_to_north,
          EAST => move_to_east,
          SOUTH => move_to_south,
          WEST => move_to_west
        }

        new_positions[position.direction]
      end

      private

      def turn_right
        turn = {
          NORTH => EAST,
          EAST => SOUTH,
          SOUTH => WEST,
          WEST => NORTH
        }

        position.direction = turn[position.direction]
      end

      def move_forward
        puts "move_forward: #{position.to_a}"
        new_position = next_step_position
        @position = new_position
        raise LoopError if already_visited?(new_position)

        @visited_positions << new_position
      end

      def already_visited?(position)
        visited_positions.any? { |visited_position| visited_position.to_a == position.to_a }
      end

      def position_into_map?(position, map)
        position.row >= 0 && position.row < map.size &&
          position.col >= 0 && position.col < map[position.row].size
      end

      def locked_position?(position, map)
        map[position.row][position.col] == BLOCKED_POSITION
      end

      def move_to_north
        Position.new(position.row - 1, position.col, position.direction)
      end

      def move_to_east
        Position.new(position.row, position.col + 1, position.direction)
      end

      def move_to_south
        Position.new(position.row + 1, position.col, position.direction)
      end

      def move_to_west
        Position.new(position.row, position.col - 1, position.direction)
      end
    end
  end
end
