module Year2024
  module Day3
    class Resolver
      FILE_PATH = 'lib/year_2024/day_3/input.txt'

      attr_reader :file_content

      def initialize
        file_content = File.read(FILE_PATH)
        @file_content = file_content
      end

      def run_case_1
        numbers = self.class.get_valid_commands(file_content)
        self.class.sum_valid_commands(numbers)
      end

      def run_case_2
        numbers = self.class.filter_actionable_commands(file_content)
        self.class.sum_valid_commands(numbers)
      end

      def self.get_valid_commands(memory_string)
        memory_string.scan(/mul\((\d+),(\d+)\)/)
      end

      def self.sum_valid_commands(valid_commands)
        sum = 0

        valid_commands.each do |pair|
          sum += pair[0].to_i * pair[1].to_i
        end

        sum
      end

      def self.filter_actionable_commands(memory_string)
        split_by_do = memory_string.split('do')
        numbers = []

        split_by_do.map do |substring|
          next if substring.slice(0, 3) == "n't"
          get_valid_commands(substring).each{ |pair| numbers << pair } 
        end

        numbers
      end
    end
  end
end
