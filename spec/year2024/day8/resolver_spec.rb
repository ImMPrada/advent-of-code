require 'spec_helper'

RSpec.describe Year2024::Day8::Resolver do
  subject(:resolver) { described_class.new(file_path) }

  let(:file_path) { 'spec/year2024/day8/input.txt' }

  describe '#initialize' do
    let(:expected_antennas_amount) { 7 }

    it 'lists all antennas' do
      expect(resolver.antennas.size).to eq(expected_antennas_amount)
    end
  end

  describe '#run_case1' do
    it 'returns the correct number of antinodes' do
      expect(resolver.run_case1).to eq(14)
    end
  end
end
