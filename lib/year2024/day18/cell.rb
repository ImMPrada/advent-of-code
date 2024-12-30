module Year2024
  module Day18
    class Cell
      attr_reader :x, :y
      attr_accessor :corrupted

      def initialize(x_coord:, y_coord:)
        @x = x_coord
        @y = y_coord
        @corrupted = false
      end

      def corrupt!
        @corrupted = true
      end

      def safe?
        !corrupted
      end

      def to_s
        corrupted ? '#' : '.'
      end

      def to_a
        [x, y]
      end
    end
  end
end
