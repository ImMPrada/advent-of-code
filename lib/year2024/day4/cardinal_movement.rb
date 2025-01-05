require './lib/year2024/day4/direction_constructors'
require './lib/year2024/day4/movement_limits'

module Year2024
  module Day4
    class CardinalMovement
      attr_reader :row_limit, :column_limit

      extend DirectionConstructors

      include MovementLimits

      def initialize(row, column, index_offset, main_direction, secondary_direction, input_puzzle)
        @row = row
        @column = column
        @index_offset = index_offset
        @main_direction = main_direction
        @secondary_direction = secondary_direction
        @northen_border = 0
        @western_border = 0
        @southern_border = input_puzzle.row_count - 1
        @eastern_border = input_puzzle.column_count - 1
      end

      def can_move_to?(row, column)
        vertical_conditional = row >= @northen_border && row <= @southern_border
        horizontal_conditional = column >= @western_border && column <= @eastern_border

        main_direction_conditional, secondary_direction_conditional = can_move_in_main_and_secondary?(row, column)

        vertical_conditional && horizontal_conditional && main_direction_conditional && secondary_direction_conditional
      end

      def next_position(row, column)
        next_row, next_column = compute_next_position_for_main_direction(row, column)
        if secondary_direction
          next_row, next_column = compute_next_position_for_secondary_direction(next_row, next_column)
        end

        [next_row, next_column]
      end

      private

      attr_reader :row, :column, :index_offset, :main_direction, :secondary_direction

      def compute_next_position_for_main_direction(row, column)
        next_row = row
        next_column = column

        case main_direction
        when NORTH
          next_row -= 1
        when WEST
          next_column -= 1
        when SOUTH
          next_row += 1
        when EAST
          next_column += 1
        end

        [next_row, next_column]
      end

      def compute_next_position_for_secondary_direction(row, column)
        next_row = row
        next_column = column

        case secondary_direction
        when WEST
          next_column -= 1
        when EAST
          next_column += 1
        end

        [next_row, next_column]
      end

      def can_move_in_main_and_secondary?(row, column)
        case main_direction
        when NORTH
          main_direction_conditional = row >= row_limit
        when WEST
          main_direction_conditional = column >= column_limit
        when SOUTH
          main_direction_conditional = row <= row_limit
        when EAST
          main_direction_conditional = column <= column_limit
        end

        secondary_direction_conditional = true

        case secondary_direction
        when WEST
          secondary_direction_conditional = column >= column_limit
        when EAST
          secondary_direction_conditional = column <= column_limit
        end

        [main_direction_conditional, secondary_direction_conditional]
      end
    end
  end
end
