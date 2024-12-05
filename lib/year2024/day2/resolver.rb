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

      def run_case1
        safe_reports = reports.select { |report| report_safe?(report) }
        puts "#{safe_reports.size}/#{reports.size}"
        safe_reports.size
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
        left_diff = diff_magnitude(report[left_index], report[left_index + 1])
        right_diff = diff_magnitude(report[right_index - 1], report[right_index])

        (left_diff.positive? && left_diff <= DIFF_LIMIT) && (right_diff.positive? && right_diff <= DIFF_LIMIT)
      end

      def valid_direction?(direction, global_direction, report, left_index, right_index)
        left_direction = levels_direction(report[left_index], report[left_index + 1])
        right_direction = levels_direction(report[right_index - 1], report[right_index])

        puts "left side values: #{report[left_index]} #{report[left_index + 1]} -- #{left_direction} -- #{direction}"
        puts "right side values: #{report[right_index - 1]} #{report[right_index]} -- #{right_direction} -- #{direction}"
        (left_direction == direction) && (right_direction == direction) && (direction == global_direction)
      end

      def check_report(report, left_index, right_index, direction = nil)
        left_value = report[left_index]
        right_value = report[right_index]
        border_direction = levels_direction(left_value, right_value)

        return false if border_direction == NEITHER_DECREASE_NOR_INCREASE
        return false unless diff_within_limit?(report, left_index, right_index)
        unless valid_direction?(border_direction, direction || border_direction, report, left_index, right_index)
          return false
        end
        return true if left_index + 1 >= right_index - 1

        check_report(report, left_index + 1, right_index - 1, border_direction)
      end
    end
  end
end
