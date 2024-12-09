require 'spec_helper'

RSpec.describe Year2024::Day1::Resolver do
  subject(:resolver) { described_class.new('spec/year2024/day1/input.txt') }

  describe '#sort_lists' do
    before do
      resolver.sort_lists
    end

    it 'sorts the list1' do
      expect(resolver.list1).to eq([1, 2, 3, 3, 3, 4])
    end

    it 'sorts the list2' do
      expect(resolver.list2).to eq([3, 3, 3, 4, 5, 9])
    end
  end

  describe '#run_case1' do
    before do
      resolver.sort_lists
    end

    it 'returns the sum of the absolute differences' do
      expect(resolver.run_case1).to eq(11)
    end
  end

  describe '#list_numbers_occurrences' do
    let(:expected_result) do
      {
        3 => 3,
        4 => 1,
        5 => 1,
        9 => 1
      }
    end

    it 'returns the numbers and their occurrences' do
      expect(resolver.list_numbers_occurrences).to eq(expected_result)
    end
  end

  describe '#run_case2' do
    let(:expected_result) { 31 }

    it 'returns the sum of the valid commands' do
      expect(resolver.run_case2).to eq(expected_result)
    end
  end
end
