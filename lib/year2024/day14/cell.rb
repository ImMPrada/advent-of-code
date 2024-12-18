module Year2024
  module Day14
    class Cell
      attr_reader :x, :y, :occupying

      def initialize(x_coord:, y_coord:)
        @x = x_coord
        @y = y_coord
        @occupying = []
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
