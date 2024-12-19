module Year2024
  module Day10
    class TrailStep
      attr_reader :cell
      attr_accessor :north, :east, :south, :west

      def initialize(cell:, north: nil, east: nil, south: nil, west: nil)
        @cell = cell
        @north = north
        @east = east
        @south = south
        @west = west
      end
    end
  end
end
