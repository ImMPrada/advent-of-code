module Year2024
  module Day16
    class Node
      FORWARD_COST = 1
      TURN_COST = 1000

      attr_reader :cell, :direction, :price, :previous_node

      def initialize(cell:, direction:, price: 0, previous_node: nil)
        @cell = cell
        @direction = direction
        @price = price
        @previous_node = previous_node
      end

      def neighbors(map)
        neighbors = []

        add_forward_neighbor(map, neighbors)
        add_clockwise_neighbor(map, neighbors)
        add_counterclockwise_neighbor(map, neighbors)

        neighbors
      end

      private

      def add_forward_neighbor(map, neighbors)
        forward_cell = next_cell(map)
        return unless forward_cell&.empty?

        neighbors << Node.new(
          cell: forward_cell,
          direction: direction,
          price: price + FORWARD_COST,
          previous_node: self
        )
      end

      def add_clockwise_neighbor(map, neighbors)
        clockwise_dir = turn_clockwise
        clockwise_cell = next_cell(map, clockwise_dir)
        return unless clockwise_cell&.empty?

        neighbors << Node.new(
          cell: clockwise_cell,
          direction: clockwise_dir,
          price: price + TURN_COST + FORWARD_COST,
          previous_node: self
        )
      end

      def add_counterclockwise_neighbor(map, neighbors)
        counter_dir = turn_counterclockwise
        counter_cell = next_cell(map, counter_dir)
        return unless counter_cell&.empty?

        neighbors << Node.new(
          cell: counter_cell,
          direction: counter_dir,
          price: price + TURN_COST + FORWARD_COST,
          previous_node: self
        )
      end

      def next_cell(map, dir = direction)
        dx, dy = direction_to_delta(dir)
        target_x = cell.x + dx
        target_y = cell.y + dy
        map[target_x, target_y]
      end

      def direction_to_delta(dir)
        delta = {
          'N' => [0, -1],
          'E' => [1, 0],
          'S' => [0, 1],
          'W' => [-1, 0]
        }

        delta[dir]
      end

      def turn_clockwise
        { 'N' => 'E', 'E' => 'S', 'S' => 'W', 'W' => 'N' }[direction]
      end

      def turn_counterclockwise
        { 'N' => 'W', 'E' => 'N', 'S' => 'E', 'W' => 'S' }[direction]
      end
    end
  end
end
