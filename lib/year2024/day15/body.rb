require_relative 'cell'

module Year2024
  module Day15
    class Body
      attr_reader :cell, :symbol

      UP = '^'.freeze
      DOWN = 'v'.freeze
      LEFT = '<'.freeze
      RIGHT = '>'.freeze

      def initialize(symbol:, cell:)
        @symbol = symbol
        @cell = cell

        occupy_cell
      end

      def move(map, direction)
        return unless can_move?(map, direction)

        new_cell = target_cell(map, direction)
        new_cell_occupant = new_cell.occupant
        new_cell_occupant&.move(map, direction)

        release_cell
        @cell = new_cell
        occupy_cell
      end

      def can_move?(map, direction)
        new_cell = target_cell(map, direction)

        return true if new_cell.empty?
        return false if new_cell.occupant.symbol == Cell::WALL

        new_cell.occupant.can_move?(map, direction) if new_cell.occupant.symbol == Cell::BOX
      end

      def occupy_cell
        cell.occupy(self)
      end

      def release_cell
        cell.clear
      end

      private

      def target_cell(map, direction)
        return move_up(map) if direction == UP
        return move_left(map) if direction == LEFT
        return move_down(map) if direction == DOWN

        map[cell.x + 1, cell.y] if direction == RIGHT
      end

      def move_up(map)
        map[cell.x, cell.y + 1]
      end

      def move_down(map)
        map[cell.x, cell.y - 1]
      end

      def move_left(map)
        map[cell.x - 1, cell.y]
      end

      def move_right(map)
        map[cell.x + 1, cell.y]
      end
    end
  end
end
