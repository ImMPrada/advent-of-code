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
end
