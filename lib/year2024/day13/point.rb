module Year2024
  module Day13
    class Point
      attr_reader :x, :y

      def self.create_pressing_button(button, point)
        new(x_coord: point.x + button.x_offset, y_coord: point.y + button.y_offset)
      end

      def initialize(x_coord:, y_coord:)
        @x = x_coord
        @y = y_coord
      end

      def to_s
        "Point(#{x}, #{y})"
      end

      def ==(other)
        x == other.x && y == other.y
      end

      def <(other)
        x < other.x || y < other.y
      end
    end
  end
end
