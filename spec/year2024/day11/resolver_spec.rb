require 'spec_helper'

RSpec.describe Year2024::Day11::Resolver do
  subject(:resolver) { described_class.new(file_path) }

  let(:file_path) { 'spec/year2024/day11/input.txt' }

  describe '#run_case1' do
    context 'when blinking 1 time' do
      it 'updates stones list with correct amount of stones' do
        resolver.run_case1(1)
        expect(resolver.stones.to_a.size).to eq(3)
      end

      it 'updates stones list with correct numbers' do
        resolver.run_case1(1)
        expect(resolver.stones.to_a).to eq([253_000, 1, 7])
      end
    end

    context 'when blinking 6 times' do
      it 'updates stones list with correct amount of stones' do
        resolver.run_case1(6)
        expect(resolver.stones.to_a.size).to eq(22)
      end

      it 'updates stones list with correct numbers' do
        resolver.run_case1(6)
        expect(resolver.stones.to_a).to eq(
          [2_097_446_912, 14_168, 4048, 2, 0, 2, 4, 40, 48, 2024, 40, 48, 80, 96, 2, 8, 6, 7, 6, 0, 3, 2]
        )
      end
    end

    context 'when blinking 25 times' do
      it 'updates stones list with correct amount of stones' do
        resolver.run_case1(25)
        expect(resolver.stones.to_a.size).to eq(55_312)
      end
    end
  end
end
