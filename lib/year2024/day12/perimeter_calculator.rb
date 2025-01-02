module Year2024
  module Day12
    module PerimeterCalculator
      def calculate_perimeter(plot)
        plot_set = Set.new(plot)
        boundaries = find_plot_boundaries(plot)
        count_corners(plot_set, boundaries)
      end

      private

      def find_plot_boundaries(plot)
        mini, maxi = plot.map(&:first).minmax
        minj, maxj = plot.map(&:last).minmax
        { min_i: mini, max_i: maxi, min_j: minj, max_j: maxj }
      end

      def count_corners(plot_set, boundaries)
        corners = 0
        (boundaries[:min_i] - 1..boundaries[:max_i]).each do |i|
          (boundaries[:min_j] - 1..boundaries[:max_j]).each do |j|
            corner_count = evaluate_corner(plot_set, i, j)
            corners += corner_count
            log_corner_found(i, j, corners) if corner_count.positive?
          end
        end
        corners
      end

      def evaluate_corner(plot_set, i_coord, j_coord)
        coords = generate_corner_coords(i_coord, j_coord)
        result = test_coords(coords, plot_set)
        count_corner_type(result)
      end

      def generate_corner_coords(i_coord, j_coord)
        [
          [i_coord, j_coord],      # top-left
          [i_coord, j_coord + 1],  # top-right
          [i_coord + 1, j_coord],  # bottom-left
          [i_coord + 1, j_coord + 1] # bottom-right
        ]
      end

      def count_corner_type(result)
        return 1 if single_corner?(result)
        return 2 if double_corner?(result)

        0
      end

      def single_corner?(result)
        [
          [1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1],
          [1, 1, 1, 0], [1, 1, 0, 1], [1, 0, 1, 1], [0, 1, 1, 1]
        ].include?(result)
      end

      def double_corner?(result)
        [[1, 0, 0, 1], [0, 1, 1, 0]].include?(result)
      end

      def test_coords(coords, plot_set)
        coords.map { |i, j| plot_set.include?([i, j]) ? 1 : 0 }
      end
    end
  end
end
