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

  describe '#neighborhood_density' do
    let(:map) { Year2024::Day14::Map.new(7, 7) }
    let(:tested_cell) { map[2, 2] }

    before do
      map[1, 1].occupying << 'rock'
      map[1, 3].occupying << 'rock'
      map[2, 2].occupying << 'rock'
      map[2, 3].occupying << 'rock'
      map[3, 1].occupying << 'rock'
      map[3, 3].occupying << 'rock'
      map[0, 3].occupying << 'rock'
      map[1, 4].occupying << 'rock'
      map[3, 4].occupying << 'rock'
      map[4, 3].occupying << 'rock'
      map[4, 5].occupying << 'rock'
      map[4, 1].occupying << 'rock'
      map[3, 0].occupying << 'rock'
    end

    context 'when X arrangement' do
      subject(:arrangement) do
        [
          [1, 0, 1],
          [0, 1, 0],
          [1, 0, 1]
        ]
      end

      it 'computes the density of the cell' do
        expect(tested_cell.neighborhood_density(map, arrangement)).to eq(6)
      end
    end

    context 'when squared arrangement' do
      subject(:arrangement) do
        [
          [1, 1, 1],
          [1, 1, 1],
          [1, 1, 1]
        ]
      end

      it 'computes the density of the cell' do
        expect(tested_cell.neighborhood_density(map, arrangement)).to eq(7)
      end
    end

    context 'when X extended arrangement' do
      subject(:arrangement) do
        [
          [0, 1, 0, 1, 0],
          [1, 1, 0, 1, 1],
          [0, 0, 1, 0, 0],
          [1, 1, 0, 1, 1],
          [0, 1, 0, 1, 0]
        ]
      end

      it 'computes the density of the cell' do
        expect(tested_cell.neighborhood_density(map, arrangement)).to eq(12)
      end
    end
  end
end
