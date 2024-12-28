require_relative 'instruction'

module Year2024
  module Day17
    class JnzInstruction < Instruction
      def execute(computer, operand)
        if computer.registers['A'] != 0
          computer.instruction_pointer = operand
        else
          computer.instruction_pointer += 2
        end
      end

      def combo_operand?
        false
      end
    end
  end
end
