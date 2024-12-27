require 'matrix'
require_relative 'cell'

module Year2024
  module Day18
    class MemorySpace
      def initialize(size:)
        @size = size
        @grid = Matrix.build(size, size) do |row, col|
          Cell.new(x_coord: col, y_coord: row)
        end
      end

      def corrupt(x_coord, y_coord)
        @grid[y_coord, x_coord].corrupt!
      end

      def find_shortest_path
        start = [0, 0]
        target = [@size - 1, @size - 1]

        queue = [[start, 0]]
        visited = Set.new([start])

        while queue.any?
          position, steps = queue.shift
          x, y = position

          return steps if position == target

          neighbors(x, y).each do |next_x, next_y|
            next_pos = [next_x, next_y]
            next unless valid_move?(next_x, next_y)
            next if visited.include?(next_pos)

            visited.add(next_pos)
            queue << [next_pos, steps + 1]
          end
        end

        nil
      end

      def visualize(path = nil)
        puts "\nMemory Space:"
        @grid.to_a.each_with_index do |row, y|
          row.each_with_index do |cell, x|
            if path&.include?([x, y])
              print 'O'
            else
              print cell
            end
          end
          puts
        end
        puts
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
