require 'spec_helper'

RSpec.describe Year2024::Day2::Resolver do
  subject(:resolver) { described_class.new('spec/year2024/day2/input.txt') }

  describe '#run_case1' do
    let(:expected_result) { 2 }

    it 'returns the number of safe reports' do
      expect(resolver.run_case1).to eq(expected_result)
    end
  end

  describe '#report_safe?' do
    context 'when the report is safe, with decreasing' do
      let(:report) { [1, 2, 3, 4, 5] }

      it 'returns true' do
        expect(resolver.report_safe?(report)).to be(true)
      end
    end

    context 'when the report is safe, with increasing' do
      let(:report) { [15, 18, 20, 21, 23, 25, 28, 30] }

      it 'returns true' do
        expect(resolver.report_safe?(report)).to be(true)
      end
    end

    context 'when the report is not safe, no direction' do
      let(:report) { [86, 88, 91, 94, 95, 95] }

      it 'returns false' do
        expect(resolver.report_safe?(report)).to be(false)
      end
    end

    context 'when the report is not safe, limit broken' do
      let(:report) { [1, 5, 6, 7] }

      it 'returns false' do
        expect(resolver.report_safe?(report)).to be(false)
      end
    end

    context 'when the report is not safe, wrong direction' do
      let(:report) { [9, 12, 14, 16, 17, 18, 15] }

      it 'returns false' do
        expect(resolver.report_safe?(report)).to be(false)
      end
    end
  end
end
