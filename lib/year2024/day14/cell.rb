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

      def neighborhood_density(map, arrangement)
        middle_row = arrangement.size / 2
        middle_col = arrangement.first.size / 2

        compute_density(map, arrangement, middle_row, middle_col)
      end

      def delta_indexes(col_index, row_index, middle_row, middle_col)
        delta_x = col_index - middle_col
        delta_y = row_index - middle_row
        [delta_x, delta_y]
      end

      def neighbor_cell(map, col_index, row_index, middle_row, middle_col)
        delta_x, delta_y = delta_indexes(col_index, row_index, middle_row, middle_col)
        neighbor_x = x + delta_x
        neighbor_y = y + delta_y
        map.cell_at(neighbor_x, neighbor_y)
      end

      def compute_density(map, arrangement, middle_row, middle_col)
        density = occupying.size

        arrangement.each_with_index do |row, row_index|
          row.each_with_index do |value, col_index|
            neighbor = neighbor_cell(map, col_index, row_index, middle_row, middle_col)
            next unless neighbor
            next if neighbor.empty?

            density += value * neighbor.occupying.size
          end
        end

        density
      end

      def arrangement_center?(row_index, col_index, middle_row, middle_col)
        row_index == middle_row && col_index == middle_col
      end

      def to_a
        [x, y]
      end
    end
  end
end
