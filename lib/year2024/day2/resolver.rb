module Year2024
  module Day2
    class Resolver
      FILE_PATH = 'lib/year2024/day2/input.txt'.freeze

      NEITHER_DECREASE_NOR_INCREASE = :none
      INCREASE = :increase
      DECREASE = :decrease
      DIFF_LIMIT = 3

      attr_reader :reports

      def initialize(path = nil)
        file_content = File.read(path || FILE_PATH)
        @reports = file_content.split("\n").map { |line| line.split.map(&:to_i) }
      end

      def report_safe?(report)
        left_index = 0
        right_index = report.size - 1

        check_report(report, left_index, right_index)
      end

      private

      def levels_direction(level1, level2)
        return NEITHER_DECREASE_NOR_INCREASE if level1 == level2
        return INCREASE if level1 < level2

        DECREASE
      end

      def diff_magnitude(level1, level2)
        (level1 - level2).abs
      end

      def diff_within_limit?(report, left_index, right_index)
        diff_magnitude(
          report[left_index],
          report[left_index + 1]
        ) <= DIFF_LIMIT && diff_magnitude(
          report[right_index - 1],
          report[right_index]
        ) <= DIFF_LIMIT
      end

      def check_report(report, left_index, right_index, direction = nil)
        left_value = report[left_index]
        right_value = report[right_index]
        border_direction = levels_direction(left_value, right_value)
        return false if border_direction == NEITHER_DECREASE_NOR_INCREASE
        return false unless diff_within_limit?(report, left_index, right_index)
        return false if direction.present? && border_direction != direction
        return true if left_index + 1 >= right_index

        check_report(report, left_index + 1, right_index - 1, border_direction)
      end
    end
  end
end
