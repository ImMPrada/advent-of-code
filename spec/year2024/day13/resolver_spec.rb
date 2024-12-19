require 'spec_helper'

RSpec.describe Year2024::Day13::Resolver do
  subject(:resolver) { described_class.new(file_path) }

  let(:file_path) { 'spec/year2024/day13/input.txt' }

  describe '#min_cost_for_machine' do
    context 'when target is reachable' do
      let(:machine) { resolver.machines.first }

      it 'returns the correct cost' do
        expect(resolver.min_cost_for_machine(machine)).to eq(280)
      end
    end

    context 'when target is not reachable' do
      let(:machine) { resolver.machines[1] }

      it 'returns the correct cost' do
        expect(resolver.min_cost_for_machine(machine)).to eq(Float::INFINITY)
      end
    end
  end

  describe '#run_case1' do
    it 'returns the correct cost' do
      expect(resolver.run_case1).to eq(480)
    end
  end
end
