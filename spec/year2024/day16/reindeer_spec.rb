require 'spec_helper'

RSpec.describe Year2024::Day16::Reindeer do
  subject(:reindeer) { described_class.new }

  let(:map) { Year2024::Day16::Map.new(lines) }

  describe '#find_shortest_paths_price' do
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
        expect(reindeer.find_shortest_paths_price(map)).to eq(4)
      end

      it 'builds the correct path' do
        reindeer.find_shortest_paths_price(map)
        path = reindeer.visualize_path

        expect(path).to eq([
                             [1, 3, 'E', 0],
                             [2, 3, 'E', 1],
                             [3, 3, 'E', 2],
                             [4, 3, 'E', 3],
                             [5, 3, 'E', 4]
                           ])
      end

      it 'stores only one optimal path' do
        reindeer.find_shortest_paths_price(map)
        expect(reindeer.best_paths.size).to eq(1)
      end
    end

    context 'with maze having multiple optimal paths' do
      let(:lines) do
        %w[
          #######
          #.....#
          #S...E#
          #.....#
          #######
        ]
      end

      it 'finds the correct shortest path cost' do
        expect(reindeer.find_shortest_paths_price(map)).to eq(4)
      end

      it 'all stored paths have the same cost' do
        reindeer.find_shortest_paths_price(map)
        paths = reindeer.best_paths.size.times.map { |i| reindeer.visualize_path(i) }
        costs = paths.map { |path| path.last[3] }
        expect(costs.uniq.size).to eq(1)
      end

      it 'stores unique paths only' do
        reindeer.find_shortest_paths_price(map)
        paths = reindeer.best_paths.size.times.map { |i| reindeer.visualize_path(i) }
        cells_paths = paths.map { |path| path.map { |x, y, _, _| [x, y] } }
        expect(cells_paths.uniq.size).to eq(cells_paths.size)
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
        expect(reindeer.find_shortest_paths_price(map)).to eq(7036)
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
        expect(reindeer.find_shortest_paths_price(map)).to eq(Float::INFINITY)
      end

      it 'has no best paths' do
        reindeer.find_shortest_paths_price(map)
        expect(reindeer.best_paths).to be_empty
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

    it 'returns array of positions, directions and costs after finding path' do
      reindeer.find_shortest_paths_price(map)
      expect(reindeer.visualize_path).to eq([
                                              [1, 1, 'E', 0],
                                              [2, 1, 'E', 1],
                                              [3, 1, 'E', 2]
                                            ])
    end
  end
end
