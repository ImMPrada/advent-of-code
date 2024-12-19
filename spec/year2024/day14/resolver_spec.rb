require 'spec_helper'

RSpec.describe Year2024::Day14::Resolver do
  subject(:resolver) { described_class.new(11, 7, file_path) }

  let(:file_path) { 'spec/year2024/day14/input.txt' }

  describe '#run_case1' do
    it 'returns the correct cost' do
      expect(resolver.run_case1(100)).to eq(12)
    end
  end
end
