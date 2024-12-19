require 'spec_helper'

RSpec.describe Year2024::Day12::Cell do
  let(:garden) { Year2024::Day12::Garden.new(lines) }
  let(:cell) { garden.cells.find { |cell| cell.region_name == region_name } }
  let(:lines) do
    %w[
      RRRRIICCFF
      RRRRIICCCF
      VVRRRCCFFF
      VVRCCCJFFF
      VVVVCJJCFE
      VVIVCCJJEE
      VVIIICJJEE
      MIIIIIJJEE
      MIIISIJEEE
      MMMISSJEEE
    ]
  end

  describe '#add_all_neighbors' do
    #   %w[
    #     ....II....
    #     ....II....
    #     ..........
    #     ..........
    #     ..........
    #     ..I.......
    #     ..III.....
    #     .IIIII....
    #     .III.I....
    #     ...I......
    #   ]
    let(:region_name) { 'I' }

    it 'adds all neighbors to the cell' do
      cell.add_all_neighbors(garden)
      expect(cell.neighbors).to all(be_a(described_class))
    end

    it 'adds the correct amount of neighbors' do
      cell.add_all_neighbors(garden)
      expect(cell.neighbors.count).to eq(2)
    end
  end

  describe '#perimeter' do
    let(:region_name) { 'I' }

    it 'returns the correct perimeter' do
      cell.add_all_neighbors(garden)
      expect(cell.perimeter).to eq(2)
    end
  end
end
