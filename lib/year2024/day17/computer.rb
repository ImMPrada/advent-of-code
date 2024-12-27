require_relative 'adv_instruction'
require_relative 'bxl_instruction'
require_relative 'bst_instruction'
require_relative 'jnz_instruction'
require_relative 'bxc_instruction'
require_relative 'out_instruction'
require_relative 'bdv_instruction'
require_relative 'cdv_instruction'

module Year2024
  module Day17
    class Computer
      attr_reader :registers, :output
      attr_accessor :instruction_pointer

      def initialize(program, register_a: 0, register_b: 0, register_c: 0)
        @registers = { 'A' => register_a, 'B' => register_b, 'C' => register_c }
        @program = program.split(',').map(&:to_i)
        @instruction_pointer = 0
        @output = []
      end

      def run
        while instruction_pointer < @program.size
          opcode = @program[instruction_pointer]
          operand = @program[instruction_pointer + 1]

          instruction = create_instruction(opcode)
          instruction.execute(self, operand)
        end

        output
      end

      def to_s
        "Computer(A=#{registers['A']}, B=#{registers['B']}, C=#{registers['C']}, IP=#{instruction_pointer})"
      end

      private

      def create_instruction(opcode)
        instructions = {
          0 => AdvInstruction,
          1 => BxlInstruction,
          2 => BstInstruction,
          3 => JnzInstruction,
          4 => BxcInstruction,
          5 => OutInstruction,
          6 => BdvInstruction,
          7 => CdvInstruction
        }

        instructions[opcode].new || raise("Invalid opcode: #{opcode}")
      end
    end
  end
end
