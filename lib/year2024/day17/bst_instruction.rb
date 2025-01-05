require_relative 'instruction'

module Year2024
  module Day17
    class BstInstruction < Instruction
      def execute(computer, operand)
        value = get_operand_value(operand, computer)
        computer.registers['B'] = value % 8
        computer.instruction_pointer += 2
      end

      def combo_operand?
        true
      end
    end
  end
end
