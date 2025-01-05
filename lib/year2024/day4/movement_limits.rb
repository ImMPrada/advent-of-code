require './lib/year2024/day4/direction_constructors'

module Year2024
  module Day4
    module MovementLimits
      NORTH = :north
      WEST = :west
      SOUTH = :south
      EAST = :east

      def compute_limits
        compute_main_direction_limits
        compute_secondary_direction_limits if secondary_direction
      end

      def compute_main_direction_limits
        @row_limit = row
        @column_limit = column

        case main_direction
        when NORTH
          @row_limit -= index_offset
        when WEST
          @column_limit -= index_offset
        when SOUTH
          @row_limit += index_offset
        when EAST
          @column_limit += index_offset
        end
      end

      def compute_secondary_direction_limits
        case secondary_direction
        when WEST
          @column_limit -= index_offset
        when EAST
          @column_limit += index_offset
        end
      end
    end
  end
end
