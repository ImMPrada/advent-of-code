module Year2024
  module Day14
    class Velocity
      attr_reader :x, :y

      def initialize(x_component:, y_component:)
        @x = x_component
        @y = y_component
      end

      def to_a
        [x, y]
      end
    end
  end
end
