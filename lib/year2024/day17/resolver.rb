require_relative 'computer'

module Year2024
  module Day17
    class Resolver
      FILE_PATH = 'lib/year2024/day17/input.txt'.freeze

      attr_reader :register_a, :register_b, :register_c, :program, :program_numbers

      def initialize(path = nil)
        file_path = path || FILE_PATH
        lines = File.readlines(file_path).map(&:chomp)

        @register_a = extract_register_value(lines[0])
        @register_b = extract_register_value(lines[1])
        @register_c = extract_register_value(lines[2])
        @program = extract_program(lines[4])
        @program_numbers = @program.split(',').map(&:to_i)
      end

      def run_case1
        computer = Computer.new(
          program,
          register_a:,
          register_b:,
          register_c:
        )

        computer.run.join(',')
      end

      def run_case2
        puts 'TODO'
      end

      private

      def extract_register_value(line)
        line.split(': ').last.to_i
      end

      def extract_program(line)
        line.split('Program: ').last
      end
    end
  end
end
