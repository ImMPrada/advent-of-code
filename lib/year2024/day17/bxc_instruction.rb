require_relative 'instruction'

module Year2024
  module Day17
    class BxcInstruction < Instruction
      def execute(computer, _operand)
        computer.registers['B'] ^= computer.registers['C']
        computer.instruction_pointer += 2
      end

      def combo_operand?
        false
      end
    end
  end
end
