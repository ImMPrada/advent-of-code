require 'spec_helper'

RSpec.describe Year2024::Day12::Garden do
  subject(:garden) { described_class.new(lines) }

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

  describe '#build_regions' do
    let(:expected_regions_roots_amount) do
      {
        'R' => 1,
        'I' => 2,
        'C' => 2,
        'F' => 1,
        'V' => 1,
        'J' => 1,
        'E' => 1,
        'M' => 1,
        'S' => 1
      }
    end

    before { garden.build_regions }

    it 'groups cells into regions' do
      expect(garden.regions).to all(be_a(Year2024::Day12::Region))
    end

    it 'adds correct amount of roots to each region' do
      expect(garden.regions.map { |region| region.roots.size }).to eq([1, 2, 2, 1, 1, 1, 1, 1, 1])
    end
  end

  describe '#regions_prices' do
    let(:expected_prices) do
      {
        'R' => 216,
        'I' => 340,
        'C' => 396,
        'F' => 180,
        'V' => 260,
        'J' => 220,
        'E' => 234,
        'M' => 60,
        'S' => 24
      }
    end

    it 'returns the price of each region' do
      garden.build_regions
      expect(garden.regions_prices).to eq(expected_prices)
    end
  end
end
