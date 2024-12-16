module Year2024
  module Day11
    class Stone
      attr_reader :number

      def initialize(number)
        @number = number
      end

      def rule1?
        number.zero?
      end

      def apply_rule1
        @number = 1
      end

      def rule2?
        number_string = number.to_s
        number_string.size.even?
      end

      def apply_rule3
        @number = number * 2024
      end
    end
  end
end
