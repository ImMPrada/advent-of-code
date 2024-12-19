require_relative 'body'

module Year2024
  module Day15
    class Box < Body
      def initialize(cell:)
        super(symbol: Cell::BOX, cell:)
      end
    end
  end
end
