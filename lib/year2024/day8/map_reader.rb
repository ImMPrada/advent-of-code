module Year2024
  module Day8
    class MapReader
      attr_reader :read_map

      def initialize(lines)
        @read_map = lines
      end

      def out_of_bounds?(position)
        out_of_bounds_row?(position.row) || out_of_bounds_col?(position.col)
      end

      private

      def out_of_bounds_row?(row)
        row.negative? || row >= read_map.size
      end

      def out_of_bounds_col?(col)
        col.negative? || col >= read_map[0].size
      end
    end
  end
end
