require 'spec_helper'

RSpec.describe Year2024::Day17::Computer do
  subject(:computer) { described_class.new(program, **registers) }

  describe '#run' do
    context 'with example from problem' do
      let(:program) { '0,1,5,4,3,0' }
      let(:registers) { { register_a: 2024 } }

      it 'outputs the correct sequence' do
        expect(computer.run.join(',')).to eq('4,2,5,6,7,7,7,7,3,1,0')
      end
    end

    context 'with simple operations' do
      context 'when using adv instruction' do
        let(:program) { '0,1' }
        let(:registers) { { register_a: 10 } }

        it 'divides register A by 2^operand' do
          computer.run
          expect(computer.registers['A']).to eq(5)
        end
      end

      context 'when using bxl instruction' do
        let(:program) { '1,7' }
        let(:registers) { { register_b: 29 } }

        it 'performs XOR on register B' do
          computer.run
          expect(computer.registers['B']).to eq(26)
        end
      end
    end
  end
end
