require 'spec_helper'

RSpec.describe Year2024::Day6::Resolver do
  subject(:resolver) { described_class.new(file_path) }

  let(:file_path) { 'spec/year2024/day6/input.txt' }

  describe '#run_case1' do
    let(:expected_result) { 26 }

    it 'returns the number of visited positions' do
      expect(resolver.run_case1).to eq(expected_result)
    end
  end
end
