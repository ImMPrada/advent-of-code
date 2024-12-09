require 'spec_helper'

RSpec.describe Year2024::Day5::Resolver do
  subject(:resolver) { described_class.new(file_path) }

  let(:file_path) { 'spec/year2024/day5/input.txt' }

  describe '#filter_valid_order_updates' do
    let(:expected_result) do
      [
        [75, 47, 61, 53, 29],
        [97, 61, 53, 29, 13],
        [75, 29, 13]
      ]
    end

    it 'returns the right order updates' do
      expect(resolver.filter_valid_order_updates).to match_array(expected_result)
    end
  end
end
