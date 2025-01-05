require 'spec_helper'

RSpec.describe Year2024::Day11::Stones do
  subject(:stones) { described_class.new(stones_list) }

  describe '#blink' do
    before { stones.blink }

    let(:stones_list) { [Year2024::Day11::Stone.new(number)] }

    context "when stone's number is 0" do
      let(:number) { 0 }

      it 'changes its number to 1' do
        expect(stones.list.first.number).to eq(1)
      end

      it 'keeps stones list as a list of stones' do
        expect(stones.list).to all(be_a(Year2024::Day11::Stone))
      end

      it 'keeps stones list size' do
        expect(stones.list.size).to eq(1)
      end
    end

    context "when stone's number digits are even" do
      let(:number) { 1000 }
      let(:stone) { Year2024::Day11::Stone.new(number) }
      let(:stones_list) { [stone] }

      it 'removes itself form stones list' do
        expect(stones.list.include?(stone)).to be(false)
      end

      it 'keeps sontes list as a list of stones' do
        expect(stones.list).to all(be_a(Year2024::Day11::Stone))
      end

      it 'adds two stones with correct numbers' do
        expect(stones.list.map(&:number)).to contain_exactly(10, 0)
      end
    end

    context "when stone's number doesn't apply to other cases" do
      let(:number) { 125 }

      it 'updates the number multiplyed' do
        expect(stones.list.first.number).to eq(number * 2024)
      end
    end
  end
end
