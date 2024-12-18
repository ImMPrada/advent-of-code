module Year2024
  module Day14
    class Velocity
      attr_reader :x, :y

      def initialize(x_vector:, y_vector:)
        @x = x_vector
        @y = y_vector
      end

      def to_a
        [x, y]
      end
    end
  end
end
