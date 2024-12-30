require_relative 'remote_control'

module Year2024
  module Day21
    class Resolver
      FILE_PATH = 'lib/year2024/day21/input.txt'.freeze
      NUMERIC_KEYPAD = [
        %w[7 8 9],
        %w[4 5 6],
        %w[1 2 3],
        [nil, '0', 'A']
      ].freeze
      DIRECTIONAL_KEYPAD = [
        [nil, '^', 'A'],
        ['<', 'v', '>']
      ].freeze

      attr_reader :codes, :door_control, :first_robot_control, :second_robot_control

      def initialize(path = nil)
        file_path = path || FILE_PATH
        @codes = File.readlines(file_path).map(&:chomp)
        @door_control = RemoteControl.new(NUMERIC_KEYPAD)
        @first_robot_control = RemoteControl.new(DIRECTIONAL_KEYPAD)
        @second_robot_control = RemoteControl.new(DIRECTIONAL_KEYPAD)
      end

      def run_case1
        codes.map do |code|
          code_complexity = complexity(last_robot_code_for(code), code)
          puts "code_complexity: #{code_complexity}"
          puts '--------------------------------'
          puts ''
          code_complexity
        end.sum
      end

      def last_robot_code_for(code)
        first_robot_instructions = build_instructions(
          build_sequence(code),
          door_control
        )
        second_robot_instructions = build_instructions(
          build_sequence(first_robot_instructions.join),
          first_robot_control
        )
        third_robot_instructions = build_instructions(
          build_sequence(second_robot_instructions.join),
          second_robot_control
        )

        third_robot_instructions.join
      end

      private

      def build_sequence(code)
        code = "A#{code}"
        code.chars.each_cons(2).to_a
      end

      def build_instructions(sequence, control)
        sequence.map do |pair|
          from_button = pair[0]
          to_button = pair[1]
          path = control.find_path_between(from_button, to_button)
          path + ['A']
        end.flatten
      end

      def complexity(instruction_string, code)
        puts "  instruction_string: #{instruction_string}"
        puts "  code: #{code}"
        code_number = code[0...-1].to_i
        puts "  code_number: #{code_number}"
        puts "  length: #{instruction_string.length}"
        instruction_string.length * code_number
      end
    end
  end
end
