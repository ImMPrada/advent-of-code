module Year2024
  module Day15
    class Cell
      attr_reader :x, :y, :occupant

      BOX = 'O'.freeze
      WALL = '#'.freeze
      ROBOT = '@'.freeze

      def initialize(x_coord:, y_coord:, occuppant: nil)
        @x = x_coord
        @y = y_coord
        @occupant = occuppant
      end

      def occupy(occupant)
        @occupant = occupant
      end

      def clear
        @occupant = nil
      end

      def empty?
        occupant.nil?
      end

      def to_a
        [x, y]
      end
    end
  end
end
