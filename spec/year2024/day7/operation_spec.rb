require 'spec_helper'

RSpec.describe Year2024::Day7::Operation do
  subject(:resolver) { described_class.new(result, numbers) }

  let(:numbers) { [9, 7, 18, 13] }
  let(:result) { 1147 }

  describe '#result_possible?' do
    it 'returns true' do
      expect(resolver.result_possible?).to be(true)
    end

    context 'when the result is not possible' do
      let(:result) { 21_037 }

      it 'returns false' do
        expect(resolver.result_possible?).to be(false)
      end
    end
  end

  describe '#possible_results' do
    let(:expected_result) { [47, 442, 301, 3744, 94, 1053, 1147, 14_742] }

    it 'returns an array' do
      expect(resolver.possible_results).to be_an(Array)
    end

    it 'returns the possible results' do
      expect(resolver.possible_results).to eq(expected_result)
    end
  end
end
