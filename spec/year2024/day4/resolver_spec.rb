require 'spec_helper'

RSpec.describe Year2024::Day2::Resolver do
  subject(:resolver) { described_class.new('spec/year2024/day4/input.txt') }

  describe '#initialize' do
    it 'returns true' do
      expect(true).to eq(true)
    end
  end
end
