require_relative 'instruction'

module Year2024
  module Day17
    class BxlInstruction < Instruction
      def execute(computer, operand)
        computer.registers['B'] ^= operand
        computer.instruction_pointer += 2
      end

      def combo_operand?
        false
      end
    end
  end
end
