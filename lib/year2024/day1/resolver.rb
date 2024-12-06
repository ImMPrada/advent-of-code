module Year2024
  module Day1
    class Resolver
      FILE_PATH = 'lib/year2024/day1/input.txt'.freeze

      attr_reader :file_content, :list1, :list2

      def initialize(path = nil)
        file_content = File.read(path || FILE_PATH)

        @list1 = []
        @list2 = []

        file_content.each_line do |line_i|
          value_i1, value_i2 = line_i.split.map(&:to_i)
          @list1 << value_i1.to_i
          @list2 << value_i2.to_i
        end

        @file_content = file_content
      end

      def run_case1
        sort_lists
        sum = 0

        list1.each_with_index do |value_i1, index|
          sum += (value_i1 - list2[index]).abs
        end

        sum
      end

      def run_case2
        found_numbers = list_numbers_occurrences
        sum = 0

        list1.each do |value|
          next unless found_numbers.key?(value)

          sum += found_numbers[value] * value
        end

        sum
      end

      def sort_lists
        @list1.sort!
        @list2.sort!
      end

      def list_numbers_occurrences
        found_numbers = {}

        list2.each do |value|
          if found_numbers.key?(value)
            found_numbers[value] = found_numbers[value] + 1
            next
          end

          found_numbers[value] = 1
        end

        found_numbers
      end
    end
  end
end
