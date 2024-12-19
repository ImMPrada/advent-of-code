require 'spec_helper'

RSpec.describe Year2024::Day15::Resolver do
  subject(:resolver) { described_class.new(file_path) }

  let(:file_path) { 'spec/year2024/day15/input.txt' }

  describe '#run_case1' do
    it 'returns the correct cost' do
      expect(resolver.run_case1).to eq(10_092)
    end
  end
end
