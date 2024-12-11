module Year2024
  module Day7
    class Operation
      FILE_PATH = 'lib/year2024/day7/input.txt'.freeze
      OPERATORS = %i[+ *].freeze

      attr_reader :result, :numbers

      def initialize(result, numbers)
        @result = result
        @numbers = numbers
      end

      def result_possible?
        possible_results.include?(result)
      end

      def possible_results
        root = numbers.first
        queue = [root]

        numbers[1..].each do |number|
          next_queue = []

          while queue.any?
            current = queue.shift

            OPERATORS.each do |operator|
              next_queue << current.send(operator, number)
            end
          end

          queue = next_queue
        end

        queue
      end
    end
  end
end
