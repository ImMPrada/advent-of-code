require 'spec_helper'

RSpec.describe Year2024::Day16::Reindeer do
  subject(:reindeer) { described_class.new }

  let(:map) { Year2024::Day16::Map.new(lines) }

  describe '#find_shortest_path' do
    context 'with simple maze' do
      let(:lines) do
        %w[
          #######
          #.....#
          #.###.#
          #S...E#
          #######
        ]
      end

      it 'finds the shortest path' do
        expect(reindeer.find_shortest_path(map)).to eq(4)
      end

      it 'builds the correct path' do
        reindeer.find_shortest_path(map)
        path = reindeer.visualize_path

        expect(path).to eq([
                             [1, 3, 'E'],
                             [2, 3, 'E'],
                             [3, 3, 'E'],
                             [4, 3, 'E'],
                             [5, 3, 'E']
                           ])
      end
    end

    context 'with maze requiring turns' do
      let(:lines) do
        %w[
          #########
          #S..#...#
          #.#.#.#.#
          #.....#E#
          #########
        ]
      end

      it 'finds the shortest path with turns' do
        expect(reindeer.find_shortest_path(map)).to eq(5012)
      end
    end

    context 'with example from problem statement' do
      let(:lines) do
        %w[
          ###############
          #.......#....E#
          #.#.###.#.###.#
          #.....#.#...#.#
          #.###.#####.#.#
          #.#.#.......#.#
          #.#.#####.###.#
          #...........#.#
          ###.#.#####.#.#
          #...#.....#.#.#
          #.#.#.###.#.#.#
          #.....#...#.#.#
          #.###.#.#.#.#.#
          #S..#.....#...#
          ###############
        ]
      end

      it 'finds the correct path cost of 7036' do
        expect(reindeer.find_shortest_path(map)).to eq(7036)
      end
    end

    context 'with no possible path' do
      let(:lines) do
        %w[
          #####
          #S#E#
          #####
        ]
      end

      it 'returns infinity when no path exists' do
        expect(reindeer.find_shortest_path(map)).to eq(Float::INFINITY)
      end

      it 'has no best path' do
        reindeer.find_shortest_path(map)
        expect(reindeer.best_path).to be_nil
      end
    end
  end

  describe '#visualize_path' do
    let(:lines) do
      %w[
        #####
        #S.E#
        #####
      ]
    end

    it 'returns nil before finding path' do
      expect(reindeer.visualize_path).to be_nil
    end
  end
end
