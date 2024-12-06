module Year2024
  module Day4
    module DirectionConstructors
      def northen(row, col, index_offset, input_puzzle)
        new(
          row,
          col,
          index_offset,
          Year2024::Day4::CardinalMovement::NORTH,
          nil,
          input_puzzle
        )
      end

      def north_western(row, col, index_offset, input_puzzle)
        new(
          row,
          col,
          index_offset,
          Year2024::Day4::CardinalMovement::NORTH,
          Year2024::Day4::CardinalMovement::WEST,
          input_puzzle
        )
      end

      def western(row, col, index_offset, input_puzzle)
        new(
          row,
          col,
          index_offset,
          Year2024::Day4::CardinalMovement::WEST,
          nil,
          input_puzzle
        )
      end

      def south_western(row, col, index_offset, input_puzzle)
        new(
          row,
          col,
          index_offset,
          Year2024::Day4::CardinalMovement::SOUTH,
          Year2024::Day4::CardinalMovement::WEST,
          input_puzzle
        )
      end

      def southern(row, col, index_offset, input_puzzle)
        new(
          row,
          col,
          index_offset,
          Year2024::Day4::CardinalMovement::SOUTH,
          nil,
          input_puzzle
        )
      end

      def south_eastern(row, col, index_offset, input_puzzle)
        new(
          row,
          col,
          index_offset,
          Year2024::Day4::CardinalMovement::SOUTH,
          Year2024::Day4::CardinalMovement::EAST,
          input_puzzle
        )
      end

      def eastern(row, col, index_offset, input_puzzle)
        new(
          row,
          col,
          index_offset,
          Year2024::Day4::CardinalMovement::EAST,
          nil,
          input_puzzle
        )
      end

      def north_eastern(row, col, index_offset, input_puzzle)
        new(
          row,
          col,
          index_offset,
          Year2024::Day4::CardinalMovement::NORTH,
          Year2024::Day4::CardinalMovement::EAST,
          input_puzzle
        )
      end
    end
  end
end
