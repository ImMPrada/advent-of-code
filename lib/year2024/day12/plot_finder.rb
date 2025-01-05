module Year2024
  module Day12
    module PlotFinder
      DIRECTIONS = [[-1, 0], [0, 1], [1, 0], [0, -1]].freeze

      def find_plots(grid)
        n = grid.size
        seen = Set.new
        plots = []

        n.times do |i|
          n.times do |j|
            next if seen.include?([i, j])

            find_plot(grid, i, j, seen, plots)
          end
        end

        plots
      end

      private

      def find_plot(grid, start_i, start_j, seen, plots)
        stack = [[start_i, start_j]]
        plots << [grid[start_i][start_j], []]
        process_plot_stack(grid, stack, seen, plots)
      end

      def process_plot_stack(grid, stack, seen, plots)
        while stack.any?
          log_stack_progress(stack.size)
          current_i, current_j = stack.pop
          next if seen.include?([current_i, current_j])
          next unless valid_cell?(grid, current_i, current_j)
          next unless same_region?(grid, current_i, current_j, plots.last[0])

          add_cell_to_plot(current_i, current_j, seen, plots)
          add_neighbors_to_stack(grid, current_i, current_j, stack)
        end
      end

      def valid_cell?(grid, i_coord, j_coord)
        in_grid?(i_coord, j_coord, grid.size)
      end

      def same_region?(grid, i_coord, j_coord, region_char)
        grid[i_coord][j_coord] == region_char
      end

      def add_cell_to_plot(i_coord, j_coord, seen, plots)
        seen.add([i_coord, j_coord])
        plots.last[1] << [i_coord, j_coord]
        log_plot_found(plots.last[0], plots.last[1].size) if (plots.last[1].size % 10).zero?
      end

      def add_neighbors_to_stack(_grid, i_coord, j_coord, stack)
        DIRECTIONS.each do |di, dj|
          stack << [i_coord + di, j_coord + dj]
        end
      end

      def in_grid?(i_coord, j_coord, n_grid)
        (i_coord >= 0 && i_coord < n_grid) && (j_coord >= 0 && j_coord < n_grid)
      end
    end
  end
end
