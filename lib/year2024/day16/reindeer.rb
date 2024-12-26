require_relative 'node'

module Year2024
  module Day16
    class Reindeer
      attr_reader :best_path, :best_price

      def initialize
        @visited = Set.new
        @best_price = Float::INFINITY
        @best_path = nil
      end

      def find_shortest_path(map)
        queue = [Node.new(cell: map.starting_cell, direction: 'E')]
        distances = { [queue.first.cell, queue.first.direction] => 0 }

        run_loop(queue, map, distances)
        best_price
      end

      def visualize_path
        return unless @best_path

        path = []
        current = @best_path
        while current
          path.unshift([current.cell.x, current.cell.y, current.direction])
          current = current.previous_node
        end

        path
      end

      private

      attr_reader :visited

      def run_loop(queue, map, distances)
        until queue.empty?
          current_node = queue.min_by(&:price)
          queue.delete(current_node)

          state = [current_node.cell, current_node.direction]
          next if visited.include?(state)

          @visited.add(state)

          if current_node.cell == map.ending_cell
            compute_best_price(current_node)
            next
          end

          enqueue_neighbor(current_node, map, queue, distances)
        end
      end

      def compute_best_price(current_node)
        return unless current_node.price < best_price

        @best_price = current_node.price
        @best_path = current_node
      end

      def enqueue_neighbor(current_node, map, queue, distances)
        current_node.neighbors(map).each do |neighbor|
          next_state = [neighbor.cell, neighbor.direction]
          next if visited.include?(next_state)

          if neighbor.price < (distances[next_state] || Float::INFINITY)
            distances[next_state] = neighbor.price
            queue << neighbor
          end
        end
      end
    end
  end
end
