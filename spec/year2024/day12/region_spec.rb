require 'spec_helper'

RSpec.describe Year2024::Day12::Region do
  subject(:region) { described_class.new(region_name) }

  let(:garden) { Year2024::Day12::Garden.new(lines) }
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

  describe '#group_cells' do
    #   %w[
    #     0123456789
    #     ....II....  0
    #     ....II....  1
    #     ..........  2
    #     ..........  3
    #     ..........  4
    #     ..I.......  5
    #     ..III.....  6
    #     .IIIII....  7
    #     .III.I....  8
    #     ...I......  9
    #   ]

    let(:region_name) { 'I' }
    let(:expected_neighbors_coords) do
      {
        [4, 0] => [[4, 1], [5, 0]],
        [5, 0] => [[5, 1], [4, 0]],
        [4, 1] => [[4, 0], [5, 1]],
        [5, 1] => [[5, 0], [4, 1]],
        [2, 5] => [[2, 6]],
        [2, 6] => [[2, 5], [2, 7], [3, 6]],
        [3, 6] => [[2, 6], [4, 6], [3, 7]],
        [4, 6] => [[3, 6], [4, 7]],
        [1, 7] => [[1, 8], [2, 7]],
        [2, 7] => [[1, 7], [2, 6], [3, 7], [2, 8]],
        [3, 7] => [[2, 7], [3, 6], [4, 7], [3, 8]],
        [4, 7] => [[3, 7], [4, 6], [5, 7]],
        [5, 7] => [[4, 7], [5, 8]],
        [1, 8] => [[1, 7], [2, 8]],
        [2, 8] => [[1, 8], [2, 7], [3, 8]],
        [3, 8] => [[2, 8], [3, 7], [3, 9]],
        [5, 8] => [[5, 7]],
        [3, 9] => [[3, 8]]
      }
    end

    before { region.group_cells(garden) }

    it 'groups cells with correct amount of roots' do
      expect(region.roots.size).to eq(2)
    end

    it 'adds correct neighbors to the cells' do
      region.roots.each do |root|
        expect(
          root.neighbors.map { |neighbor| [neighbor.x_coord, neighbor.y_coord] }
        ).to match_array(expected_neighbors_coords[[root.x_coord, root.y_coord]])
      end
    end
  end

  describe '#root_cells' do
    #   %w[
    #     0123456789
    #     ....II....  0
    #     ....II....  1
    #     ..........  2
    #     ..........  3
    #     ..........  4
    #     ..I.......  5
    #     ..III.....  6
    #     .IIIII....  7
    #     .III.I....  8
    #     ...I......  9
    #   ]

    let(:region_name) { 'I' }

    let(:expected_cells_perimeter) do
      {
        [4, 0] => 2,
        [5, 0] => 2,
        [4, 1] => 2,
        [5, 1] => 2,
        [2, 5] => 3,
        [2, 6] => 1,
        [3, 6] => 1,
        [4, 6] => 2,
        [1, 7] => 2,
        [2, 7] => 0,
        [3, 7] => 0,
        [4, 7] => 1,
        [5, 7] => 2,
        [1, 8] => 2,
        [2, 8] => 1,
        [3, 8] => 1,
        [5, 8] => 3,
        [3, 9] => 3
      }
    end
    let(:root) { region.roots.last }

    before { region.group_cells(garden) }

    it 'returns the correct amount of cells' do
      expect(region.root_cells(root).size).to eq(14)
    end

    it "returns the correct amount of perimeter at each root's cell" do
      region.root_cells(root).each do |cell|
        expect(cell.perimeter).to eq(expected_cells_perimeter[[cell.x_coord, cell.y_coord]])
      end
    end
  end

  describe '#price' do
    let(:region_name) { 'I' }

    before { region.group_cells(garden) }

    it 'returns the correct price' do
      expect(region.price).to eq(340)
    end
  end
end
