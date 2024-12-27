require 'matrix'
require 'fileutils'
require_relative 'cell'
require_relative 'renderable'

module Year2024
  module Day18
    class MemorySpace
      include Renderable

      def initialize(size:)
        @size = size
        @grid = Matrix.build(size, size) do |row, col|
          Cell.new(x_coord: col, y_coord: row)
        end
      end

      def corrupt(x_coord, y_coord)
        @grid[y_coord, x_coord].corrupt!
      end

      def find_shortest_path(visualize: false)
        start = [0, 0]
        target = [@size - 1, @size - 1]

        queue = [[start, [start]]] # [position, path]
        visited = Set.new([start])

        while queue.any?
          position, path = queue.shift
          x, y = position

          return path.size - 1 if position == target

          neighbors(x, y).each do |next_x, next_y|
            next_pos = [next_x, next_y]
            next unless valid_move?(next_x, next_y)
            next if visited.include?(next_pos)

            visited.add(next_pos)
            queue << [next_pos, path + [next_pos]]
          end
        end

        render(nil, title: 'no_path_found') if visualize
        nil
      end

      private

      def neighbors(x_coord, y_coord)
        [
          [x_coord + 1, y_coord],
          [x_coord - 1, y_coord],
          [x_coord, y_coord + 1],
          [x_coord, y_coord - 1]
        ]
      end

      def valid_move?(x_coord, y_coord)
        return false if x_coord.negative? || x_coord >= @size
        return false if y_coord.negative? || y_coord >= @size

        @grid[y_coord, x_coord].safe?
      end

      def to_s
        @grid.to_a.map do |row|
          row.map(&:to_s).join
        end.join("\n")
      end
    end
  end
end
