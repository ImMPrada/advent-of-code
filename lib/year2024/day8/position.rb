module Year2024
  module Day8
    class Position
      attr_reader :row, :col

      def initialize(row, col)
        @row = row
        @col = col
      end

      def -(other)
        Position.new(row - other.row, col - other.col)
      end

      def +(other)
        Position.new(row + other.row, col + other.col)
      end

      def to_a
        [row, col]
      end
    end
  end
end
