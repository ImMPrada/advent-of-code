module Year2024
  module Day11
    class Stone
      attr_reader :number

      def initialize(number)
        @number = number
        @blinked = false
      end

      def blink(stones_list)
        run_rule1
        run_rule2(stones_list)
        run_rule3

        @blinked = false
      end

      def exists?
        exists
      end

      private

      attr_reader :blinked

      def run_rule1
        return if blinked
        return if number != 0

        @number = 1
        @blinked = true
      end

      def run_rule2(stones_list)
        return if blinked

        number_string = number.to_s
        return unless number_string.size.even?

        left_digits = number_string[0...number_string.size / 2]
        right_digits = number_string[number_string.size / 2..]

        update_stones_lists(stones_list, left_digits, right_digits)
        @blinked = true
      end

      def run_rule3
        return if blinked

        @number = number * 2024
        @blinked = true
      end

      def update_stones_lists(stones_list, left_digits, right_digits)
        backup_list = stones_list.dup
        stones_list.clear

        backup_list.each do |rock|
          unless rock == self
            stones_list << rock
            next
          end

          stones_list << self.class.new(left_digits.to_i)
          stones_list << self.class.new(right_digits.to_i)
        end
      end
    end
  end
end
