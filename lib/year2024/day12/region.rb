require 'matrix'

module Year2024
  module Day12
    class Region
      attr_reader :name, :roots

      def initialize(name)
        @name = name
        @roots = []
      end

      def group_cells(garden)
        garden.cells.each do |cell|
          next unless cell.region_name == name
          next if cell.grouped

          @roots << cell
          group_cell(cell, garden)
        end
      end

      def root_cells(root)
        queue = [root]
        cells = []

        while queue.any?
          current = queue.shift
          cells << current
          neighbors = current.neighbors
          neighbors.each { |neighbor| queue << neighbor unless cells.include?(neighbor) }
        end

        cells.uniq
      end

      def price
        sum = 0

        roots.each do |root|
          perimeter = 0
          area = 0

          root_cells(root).each do |cell|
            perimeter += cell.perimeter
            area += 1
          end

          sum += perimeter * area
        end

        sum
      end

      private

      def group_cell(cell, garden)
        queue = [cell]

        while queue.any?
          puts "queue: #{queue.size}"
          current = queue.shift
          current.add_all_neighbors(garden)
          current.neighbors.each { |neighbor| queue << neighbor unless neighbor.grouped }
        end
      end
    end
  end
end
