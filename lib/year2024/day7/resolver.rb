require './lib/year2024/day7/operation'

module Year2024
  module Day7
    class Resolver
      FILE_PATH = 'lib/year2024/day7/input.txt'.freeze
      OPERATORS = %i[+ *].freeze

      attr_reader :operations

      def initialize(path = nil)
        @file_path = path || FILE_PATH
        @operations = []
        build_operations
      end

      def run_case1
        possible_operations = []

        operations.each do |operation|
          possible_operations << operation.result if operation.result_possible?
        end

        possible_operations.sum
      end

      private

      attr_reader :file_path

      def build_operations
        file_content = File.read(file_path)

        file_content.split("\n").each do |line|
          operation = line.split(': ')
          operations << Operation.new(operation[0].to_i, operation[1].split(' ').map(&:to_i))
        end
      end
    end
  end
end
