require_relative 'instruction'

module Year2024
  module Day17
    class BdvInstruction < Instruction
      def execute(computer, operand)
        value = get_operand_value(operand, computer)
        computer.registers['B'] = (computer.registers['A'] / (2**value)).to_i
        computer.instruction_pointer += 2
      end

      def combo_operand?
        true
      end
    end
  end
end
