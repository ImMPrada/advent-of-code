module Year2024
  module Day14
    class Robot
      attr_reader :cell, :velocity

      def initialize(cell:, velocity:)
        @cell = cell
        @velocity = velocity

        occupy_cell
      end

      def move(map)
        new_cell = map[cell.x + velocity.x, cell.y + velocity.y]

        release_cell
        @cell = new_cell
        occupy_cell
      end

      def occupy_cell
        cell.add_occupant(self)
      end

      def release_cell
        cell.remove_occupant(self)
      end
    end
  end
end
