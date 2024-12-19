require 'spec_helper'

RSpec.describe Year2024::Day12::Resolver do
  subject(:resolver) { described_class.new(file_path) }

  let(:file_path) { 'spec/year2024/day12/input.txt' }

  describe '#run_case1' do
    it 'returns the correct price' do
      expect(resolver.run_case1).to eq(1930)
    end
  end
end
