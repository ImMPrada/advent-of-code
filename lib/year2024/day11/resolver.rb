require_relative 'stone'
require_relative 'stones'
require_relative 'loggable'

module Year2024
  module Day11
    class Resolver
      include Loggable

      FILE_PATH = 'lib/year2024/day11/input.txt'.freeze

      attr_reader :stones

      def initialize(path = nil)
        file_path = path || FILE_PATH
        line = File.readlines(file_path).map(&:chomp)[0]
        build_stones_list(line)
      end

      def run_case1
        display_initial_stones
        result = process_stones(times: 25)
        display_final_stones
        result
      end

      def run_case2
        nums = initialize_number_counts
        display_initial_state(nums)

        nums = process_blinks(nums, times: 75)

        display_final_count(nums)
        nums.values.sum
      end

      def run_for(blinking_times)
        blinking_times.times do
          stones.blink
        end
      end

      private

      def blink(nums)
        new_nums = Hash.new(0)
        nums.each { |number, count| apply_rules(new_nums, number, count) }
        new_nums
      end

      def apply_rules(new_nums, number, count)
        if number.zero?
          apply_zero_rule(new_nums, count)
        elsif even_digits?(number)
          apply_even_digits_rule(new_nums, number, count)
        else
          apply_multiplication_rule(new_nums, number, count)
        end
      end

      def apply_zero_rule(new_nums, count)
        new_nums[1] += count
      end

      def apply_even_digits_rule(new_nums, number, count)
        left, right = split_number(number)
        new_nums[left] += count
        new_nums[right] += count
      end

      def apply_multiplication_rule(new_nums, number, count)
        new_nums[number * 2024] += count
      end

      def even_digits?(number)
        number.to_s.length.even?
      end

      def split_number(number)
        number_str = number.to_s
        length = number_str.length
        [
          number_str[0...(length / 2)].to_i,
          number_str[(length / 2)..].to_i
        ]
      end

      def build_stones_list(line)
        stones_list = []

        line.split(' ').each do |number|
          stones_list << Stone.new(number.to_i)
        end

        @stones = Stones.new(stones_list)
      end

      def initialize_number_counts
        nums = Hash.new(0)
        stones.to_a.each { |n| nums[n] += 1 }
        nums
      end

      def process_blinks(nums, times:)
        times.times do |i|
          nums = blink(nums)
          display_progress(nums, i + 1) if ((i + 1) % 10).zero?
        end
        nums
      end

      def process_stones(times:)
        times.times do |i|
          stones.blink
          display_stones_progress(i + 1) if ((i + 1) % 5).zero?
        end
        stones.to_a.size
      end
    end
  end
end
