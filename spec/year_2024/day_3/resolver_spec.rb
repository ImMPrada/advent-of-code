require 'spec_helper'

RSpec.describe Year2024::Day3::Resolver do
  describe '.get_valid_commands' do
    let(:memory_string) { 'xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))' }
    let(:valid_commands) { [['2', '4'], ['5', '5'], ['11', '8'], ['8', '5']] }

    it 'returns the valid commands' do
      expect(described_class.get_valid_commands(memory_string)).to eq(valid_commands)
    end
  end

  describe '.sum_valid_commands' do
    let(:valid_commands) { [['2', '4'], ['5', '5'], ['11', '8'], ['8', '5']] }
    let(:expected_result) { 2 * 4 + 5 * 5 + 11 * 8 + 8 * 5 }

    it 'returns the sum of the valid commands' do
      expect(described_class.sum_valid_commands(valid_commands)).to eq(expected_result)
    end
  end

  describe '.filter_actionable_commands' do
    let(:memory_string) { "xmul(2,4)mul(2,5)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(2,3)mul(8,5))" }
    let(:actionable_commands) { [['2', '4'], ['2', '5'], ['2', '3'], ['8', '5']] }

    it 'returns the actionable commands' do
      expect(described_class.filter_actionable_commands(memory_string)).to eq(actionable_commands)
    end
  end

  describe '#run_case_1' do
   subject(:resolver) { described_class.new }

   let(:file_content) { 'xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))'}
   let(:expected_result) { 2 * 4 + 5 * 5 + 11 * 8 + 8 * 5 }

    before do
      allow(resolver).to receive(:file_content).and_return(file_content)
    end

    it 'returns the sum of the valid commands' do
      expect(resolver.run_case_1).to eq(expected_result)
    end
  end

  describe '#run_case_2' do
   subject(:resolver) { described_class.new }

   let(:file_content) { "xmul(2,4)mul(2,5)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(2,3)mul(8,5))" }
   let(:expected_result) { 2 * 4 + 2 * 5 + 2 * 3 + 8 * 5 }

    before do
      allow(resolver).to receive(:file_content).and_return(file_content)
    end

    it 'returns the sum of the valid commands' do
      expect(resolver.run_case_2).to eq(expected_result)
    end
  end
end
