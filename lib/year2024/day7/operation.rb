module Year2024
  module Day7
    class Operation
      OPERATORS = %i[+ *].freeze

      attr_reader :result, :numbers, :operators

      def initialize(result, numbers)
        @result = result
        @numbers = numbers
        @operators = OPERATORS
      end

      def result_possible?(custom_operators = nil)
        @operators = custom_operators if custom_operators
        possible_results.include?(result)
      end

      def possible_results
        root = numbers.first
        queue = [root]

        numbers[1..].each do |number|
          next_queue = []

          while queue.any?
            current = queue.shift

            operators.each do |operator|
              operation = OPERATORS.include?(operator) ? current.send(operator, number) : operator.call(current, number)
              next_queue << operation
            end
          end

          queue = next_queue
        end

        queue
      end
    end
  end
end
