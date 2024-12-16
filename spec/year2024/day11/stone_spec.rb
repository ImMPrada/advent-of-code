require 'spec_helper'

RSpec.describe Year2024::Day11::Stone do
  subject(:stone) { described_class.new(number) }

  describe '#blink' do
    before { stone.blink(stones_list) }

    let(:stones_list) { [stone] }

    context "when stone's number is 0" do
      let(:number) { 0 }

      it 'changes its number to 1' do
        expect(stone.number).to eq(1)
      end
    end

    context "when stone's number digits are even" do
      let(:number) { 1000 }

      it 'removes itself form stones list' do
        expect(stones_list.include?(stone)).to be(false)
      end

      it 'keeps sontes list as a list of stones' do
        expect(stones_list).to all(be_a(described_class))
      end

      it 'adds two stones with correct numbers' do
        expect(stones_list.map(&:number)).to contain_exactly(10, 0)
      end
    end

    context "when stone's number doesn't apply to other cases" do
      let(:number) { 125 }

      it 'updates the number multiplyed' do
        expect(stone.number).to eq(number * 2024)
      end
    end
  end
end
