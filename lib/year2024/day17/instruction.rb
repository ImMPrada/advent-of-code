module Year2024
  module Day17
    class Instruction
      def execute(computer, operand)
        raise NotImplementedError, "#{self.class} must implement execute"
      end

      protected

      def get_operand_value(operand, computer)
        if combo_operand?
          case operand
          when 0..3 then operand
          when 4 then computer.registers['A']
          when 5 then computer.registers['B']
          when 6 then computer.registers['C']
          when 7 then raise 'Invalid combo operand: 7'
          end
        else
          operand
        end
      end

      def combo_operand?
        raise NotImplementedError, "#{self.class} must implement combo_operand?"
      end
    end
  end
end
