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
        safe_reports.size
      end

      def run_case2
        safe_reports = []
        reports.each do |report|
          is_safe = report_safe?(report)
          if is_safe
            safe_reports << report
            next
          end

          index = 0

          while index <= report.size - 1 && !is_safe
            new_report = remove_index_item(report, index)
            is_safe = report_safe?(new_report)
            safe_reports << new_report if is_safe
            index += 1
          end
        end

        safe_reports.size
      end

      def report_safe?(report)
        index = 0
        safe = true
        direction = nil

        while index < report.size - 1
          value = report[index]
          next_value = report[index + 1]
          step_direction = levels_direction(value, next_value)
          direction = step_direction if direction.nil?
          diff = diff_magnitude(value, next_value)
          safe = valid_step?(direction, step_direction, diff)
          break unless safe

          index += 1
        end

        safe
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

      def valid_step?(direction, step_direction, diff)
        return false if step_direction == NEITHER_DECREASE_NOR_INCREASE
        return false unless direction == step_direction
        return false unless diff.between?(1, DIFF_LIMIT)

        true
      end

      def remove_index_item(arr, index)
        arr[0...index] + arr[index + 1..]
      end
    end
  end
end
