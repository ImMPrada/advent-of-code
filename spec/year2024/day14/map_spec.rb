require 'spec_helper'

RSpec.describe Year2024::Day14::Map do
  subject(:map) { described_class.new(width, height) }

  let(:width) { 11 }
  let(:height) { 7 }

  it 'creates a map with the correct number of cells' do
    expect(map.cells.count).to eq(width * height)
  end

  it 'creates a map with the correct cells' do
    expect(map.cells[0, 6].to_a).to eq([6, 0])
  end

  describe '#[]' do
    let(:test_coords) do
      [
        [0, 6],
        [0, 7],
        [10, 0],
        [10, 6],
        [10, 7],
        [13, 8],
        [13, 7],
        [7, 11],
        [7, 12]
      ]
    end

    let(:expected_coords) do
      [
        [0, 6],
        [0, 7],
        [3, 0],
        [3, 6],
        [3, 7],
        [6, 8],
        [6, 7],
        [0, 0],
        [0, 1]
      ]
    end

    it 'returns the correct cell' do
      test_coords.each_with_index do |coord, index|
        expect(map[coord[0], coord[1]].to_a).to eq(expected_coords[index])
      end
    end
  end
end
