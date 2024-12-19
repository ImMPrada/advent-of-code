module Year2024
  module Day14
    class Cell
      attr_reader :x, :y, :occupying, :in_quadrant

      def initialize(x_coord:, y_coord:, in_quadrant: false)
        @x = x_coord
        @y = y_coord
        @occupying = []
        @in_quadrant = in_quadrant
      end

      def add_occupant(occupant)
        @occupying << occupant
      end

      def remove_occupant(occupant)
        @occupying.delete(occupant)
      end

      def empty?
        @occupying.empty?
      end

      def to_a
        [x, y]
      end
    end
  end
end
