require 'spec_helper'

RSpec.describe Year2024::Day9::Resolver do
  subject(:resolver) { described_class.new(file_path) }

  let(:file_path) { 'spec/year2024/day9/input.txt' }

  describe '#run_case1' do
    it 'returns the correct number of antinodes' do
      expect(resolver.run_case1).to eq(1928)
    end
  end
end
