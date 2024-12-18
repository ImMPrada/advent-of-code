require 'spec_helper'

RSpec.describe Year2024::Day14::Cell do
  subject(:cell) { described_class.new(x_coord:, y_coord:) }

  let(:x_coord) { 0 }
  let(:y_coord) { 0 }
  let(:occupant) do
    %w[
      rock
      sand
    ]
  end

  describe '#add_occupant' do
    before do
      occupant.each { |occupant| cell.add_occupant(occupant) }
    end

    it 'adds an occupant to the cell' do
      expect(cell.occupying).to eq(occupant)
    end
  end

  describe '#remove_occupant' do
    before do
      occupant.each { |occupant| cell.add_occupant(occupant) }
      cell.remove_occupant(occupant.first)
    end

    it 'removes an occupant from the cell' do
      expect(cell.occupying).to eq([occupant.last])
    end
  end
end
