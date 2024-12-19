require 'spec_helper'

RSpec.describe Year2024::Day5::Resolver do
  subject(:resolver) { described_class.new(file_path) }

  let(:file_path) { 'spec/year2024/day5/input.txt' }

  describe '#run_case1' do
    let(:expected_result) { 143 }

    it 'returns the sum of the middle pages of the sequences' do
      expect(resolver.run_case1).to eq(expected_result)
    end
  end

  describe '#run_case2' do
    let(:expected_result) { 123 }

    it 'returns the sum of the middle pages of the sequences' do
      expect(resolver.run_case2).to eq(expected_result)
    end
  end

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

  describe '#filter_invalid_order_updates' do
    let(:expected_result) do
      [
        [75, 97, 47, 61, 53],
        [61, 13, 29],
        [97, 13, 75, 29, 47]
      ]
    end

    it 'returns the invalid order updates' do
      expect(resolver.filter_invalid_order_updates).to match_array(expected_result)
    end
  end

  describe '#sum_middle_pages_of_sequences' do
    let(:sequences) do
      [
        [75, 47, 61, 53, 29],
        [97, 61, 53, 29, 13],
        [75, 29, 13]
      ]
    end
    let(:expected_result) { 61 + 53 + 29 }

    it 'returns the sum of the middle pages of the sequences' do
      expect(resolver.sum_middle_pages_of_sequences(sequences)).to eq(expected_result)
    end
  end

  describe '#sort_sequence' do
    let(:sequences) do
      [
        [75, 97, 47, 61, 53],
        [61, 13, 29],
        [97, 13, 75, 29, 47]
      ]
    end
    let(:expected_results) do
      [
        [97, 75, 47, 61, 53],
        [61, 29, 13],
        [97, 75, 47, 29, 13]
      ]
    end

    it 'returns the ordered sequence' do
      sequences.each_with_index do |sequence, index|
        expect(resolver.sort_sequence(sequence)).to eq(expected_results[index])
      end
    end
  end
end
