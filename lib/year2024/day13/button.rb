module Year2024
  module Day13
    class Button
      attr_reader :x_offset, :y_offset, :cost

      def self.create_button_a(x_offset:, y_offset:)
        new(x_offset:, y_offset:, cost: 3)
      end

      def self.create_button_b(x_offset:, y_offset:)
        new(x_offset:, y_offset:, cost: 1)
      end

      def initialize(x_offset:, y_offset:, cost:)
        @x_offset = x_offset
        @y_offset = y_offset
        @cost = cost
      end

      def to_s
        "Button(+#{x_offset}, +#{y_offset})"
      end
    end
  end
end
