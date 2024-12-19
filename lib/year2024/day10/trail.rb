require_relative 'trail_step'

module Year2024
  module Day10
    class Trail
      attr_reader :root, :topography

      HIKING_TRAIL_DELTA = 1

      def initialize(root_cell, topography)
        @root = TrailStep.new(cell: root_cell)
        @topography = topography
        @queue = [root]
      end

      def trace_hiking_trail
        step = queue.shift
        return if step.nil?

        add_at_north(step)
        add_at_east(step)
        add_at_south(step)
        add_at_west(step)

        trace_hiking_trail
      end

      def cells
        @stack = []
        @queue = [root]

        until queue.empty?
          trail_step = queue.shift
          stack << trail_step.cell

          add_to_queue(trail_step)
        end

        stack
      end

      private

      attr_reader :queue, :stack

      def add_at_north(step)
        neighbor_cell = step.cell.northern_neighbor(topography)
        return unless neighbor_cell

        cell_height = step.cell.height
        return unless neighbor_cell.height - cell_height == HIKING_TRAIL_DELTA

        trail_step = TrailStep.new(cell: neighbor_cell)
        step.north = trail_step
        queue << trail_step
      end

      def add_at_east(step)
        neighbor_cell = step.cell.eastern_neighbor(topography)
        return unless neighbor_cell

        cell_height = step.cell.height
        return unless neighbor_cell.height - cell_height == HIKING_TRAIL_DELTA

        trail_step = TrailStep.new(cell: neighbor_cell)
        step.east = trail_step
        queue << trail_step
      end

      def add_at_south(step)
        neighbor_cell = step.cell.southern_neighbor(topography)
        return unless neighbor_cell

        cell_height = step.cell.height
        return unless neighbor_cell.height - cell_height == HIKING_TRAIL_DELTA

        trail_step = TrailStep.new(cell: neighbor_cell)
        step.south = trail_step
        queue << trail_step
      end

      def add_at_west(step)
        neighbor_cell = step.cell.western_neighbor(topography)
        return unless neighbor_cell

        cell_height = step.cell.height
        return unless neighbor_cell.height - cell_height == HIKING_TRAIL_DELTA

        trail_step = TrailStep.new(cell: neighbor_cell)
        step.west = trail_step
        queue << trail_step
      end

      def add_to_queue(trail_step)
        @queue << trail_step.north unless trail_step.north.nil?
        @queue << trail_step.east unless trail_step.east.nil?
        @queue << trail_step.south unless trail_step.south.nil?
        @queue << trail_step.west unless trail_step.west.nil?
      end
    end
  end
end
