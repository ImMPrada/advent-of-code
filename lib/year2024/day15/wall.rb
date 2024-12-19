require_relative 'body'

module Year2024
  module Day15
    class Wall < Body
      def initialize(cell:)
        super(symbol: Cell::WALL, cell:)
      end
    end
  end
end
