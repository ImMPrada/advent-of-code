module Year2024
  module Day11
    class Stones
      attr_reader :list

      def initialize(list)
        @list = list
      end

      def blink
        new_list = []

        list.each do |stone|
          blink_stone(stone, new_list)
        end

        @list = new_list
      end

      def blink_stone(stone, new_list)
        return apply_rule1(stone, new_list) if stone.rule1?
        return apply_rule2(stone, new_list) if stone.rule2?

        apply_rule3(stone, new_list)
      end

      def to_a
        list.map(&:number)
      end

      private

      def apply_rule1(stone, new_list)
        stone.apply_rule1
        new_list << stone
      end

      def apply_rule2(stone, new_list)
        number_string = stone.number.to_s

        left_side = number_string[0...number_string.size / 2]
        right_side = number_string[number_string.size / 2..]

        new_list << Stone.new(left_side.to_i)
        new_list << Stone.new(right_side.to_i)
      end

      def apply_rule3(stone, new_list)
        stone.apply_rule3
        new_list << stone
      end
    end
  end
end
