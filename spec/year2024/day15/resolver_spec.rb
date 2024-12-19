require 'spec_helper'

RSpec.describe Year2024::Day15::Resolver do
  subject(:resolver) { described_class.new(file_path) }

  let(:file_path) { 'spec/year2024/day15/input.txt' }

  describe '#run_case1' do
    it 'returns the correct cost' do
      byebug
      expect(resolver.run_case1(100)).to eq(12)
    end
  end
end
