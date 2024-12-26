require_relative 'node'

module Year2024
  module Day16
    class Reindeer
      attr_reader :best_paths, :best_price

      def initialize
        @best_price = Float::INFINITY
        @best_paths = []
        @distances = {}
      end

      def find_shortest_paths_price(map)
        start_node = Node.new(cell: map.starting_cell, direction: 'E')
        @distances = { [start_node.cell, start_node.direction] => 0 }

        explore_paths([start_node], map)
        best_price
      end

      def visualize_path(path_index = 0)
        return nil if best_paths.empty?

        path = []
        current = best_paths[path_index]
        while current
          path.unshift([current.cell.x, current.cell.y, current.direction, current.price])
          current = current.previous_node
        end

        path
      end

      private

      attr_reader :distances

      def explore_paths(queue, map)
        until queue.empty?
          current_node = queue.min_by(&:price)
          queue.delete(current_node)

          puts "queue size: #{queue.size}"

          if current_node.cell == map.ending_cell
            compute_best_price(current_node)
            next
          end

          next if current_node.price >= best_price

          enqueue_neighbors(current_node, map, queue)
        end
      end

      def compute_best_price(current_node)
        unless current_node.price < best_price
          @best_paths << current_node unless duplicate_path?(current_node)
          return
        end

        @best_price = current_node.price
        @best_paths = [current_node]
      end

      def duplicate_path?(node)
        best_paths.any? { |path| same_path?(path, node) }
      end

      def same_path?(path1, path2)
        cells1 = path_to_cells(path1)
        cells2 = path_to_cells(path2)
        cells1 == cells2
      end

      def path_to_cells(node)
        cells = []
        current = node
        while current
          cells.unshift([current.cell.x, current.cell.y])
          current = current.previous_node
        end
        cells
      end

      def enqueue_neighbors(current_node, map, queue)
        current_node.neighbors(map).each do |neighbor|
          next_state = [neighbor.cell, neighbor.direction]
          current_best = distances[next_state] || Float::INFINITY

          if neighbor.price <= current_best
            distances[next_state] = neighbor.price
            queue << neighbor
          end
        end
      end
    end
  end
end
