module Year2024
  module Day6
    class Position
      attr_reader :row, :col
      attr_accessor :direction

      def initialize(row, col, direction)
        @row = row
        @col = col
        @direction = direction
      end

      def to_a
        [row, col, direction]
      end
    end
  end
end
