module Year2024
  module Day16
    class Cell
      attr_reader :x, :y, :symbol

      WALL = '#'.freeze

      def initialize(x_coord:, y_coord:, symbol: nil)
        @x = x_coord
        @y = y_coord
        @symbol = symbol
      end

      def empty?
        !wall?
      end

      def wall?
        symbol == WALL
      end

      def to_a
        [x, y]
      end
    end
  end
end
