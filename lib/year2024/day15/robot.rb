require_relative 'body'

module Year2024
  module Day15
    class Robot < Body
      def initialize(cell:)
        super(symbol: Cell::ROBOT, cell:)
      end
    end
  end
end
