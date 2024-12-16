require 'ruby2d'

module Year2024
  module Day10
    module Renderable
      CELL_SIZE = 15 # Size of each cell in pixels

      def render(hiking_trails_cells = [])
        create_window
        render_cells_height
        render_trails(hiking_trails_cells)

        Window.show
      end

      private

      def create_window
        window_width = data.column_count * CELL_SIZE
        window_height = data.row_count * CELL_SIZE

        Window.set(
          width: window_width,
          height: window_height,
          title: 'Topography Visualization'
        )
      end

      def render_cells_height
        data.each_with_index do |cell, row, col|
          intensity = (cell.height / 9.0)

          Square.new(
            x: cell.x_coord * CELL_SIZE,
            y: cell.y_coord * CELL_SIZE,
            size: CELL_SIZE,
            color: [intensity, intensity, intensity, 1]
          )
        end
      end

      def render_trails(hiking_trails_cells)
        hiking_trails_cells.each do |cell|
          intensity = (cell.height / 9.0)

          Square.new(
            x: cell.x_coord * CELL_SIZE,
            y: cell.y_coord * CELL_SIZE,
            size: CELL_SIZE,
            color: [1, 0, 0, intensity] # Red with varying opacity based on height
          )
        end
      end
    end
  end
end
