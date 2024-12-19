require 'spec_helper'

RSpec.describe Year2024::Day10::Resolver do
  subject(:resolver) { described_class.new(file_path) }

  let(:file_path) { 'spec/year2024/day10/input.txt' }

  describe '#run_case1' do
    it 'returns the correct number of antinodes' do
      expect(resolver.run_case1).to eq(36)
    end
  end

  describe '#run_case2' do
    it 'returns the correct number of antinodes' do
      expect(resolver.run_case2).to eq(81)
    end
  end
end
