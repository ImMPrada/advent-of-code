require 'spec_helper'

RSpec.describe Year2024::Day19::Resolver do
  subject(:resolver) { described_class.new(file_path) }

  let(:file_path) { 'spec/year2024/day19/input.txt' }

  describe '#run_case1' do
    context 'with example from problem' do
      it 'counts possible designs' do
        expect(resolver.run_case1).to eq(6)
      end
    end
  end
end
