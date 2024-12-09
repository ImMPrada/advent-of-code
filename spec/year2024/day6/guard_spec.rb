require 'spec_helper'

RSpec.describe Year2024::Day6::Guard do
  subject(:resolver) { described_class.new(direction, position) }

  let(:direction) { described_class::NORTH }
  let(:position) { Year2024::Day6::Position.new(6, 4) }

  describe '#move' do
    context 'when the next position is blocked but still can move' do
      let(:map) do
        ['....#.....',
         '.........#',
         '..........',
         '..#.......',
         '.......#..',
         '#######...',
         '.#..^.....',
         '........#.',
         '#.........',
         '......#...']
      end

      it 'returns true' do
        expect(resolver.move(map)).to be(true)
      end

      it 'turns right' do
        resolver.move(map)
        expect(resolver.direction).to eq(described_class::EAST)
      end

      it 'adds the new position direction to the visited positions' do
        resolver.move(map)
        expect(resolver.visited_positions.last.last).to eq(described_class::EAST)
      end

      it 'adds the new position to the visited positions' do
        resolver.move(map)
        position_array = [resolver.visited_positions.last.first.row, resolver.visited_positions.last.first.col]
        expect(position_array).to eq([6, 5])
      end
    end

    context 'when the next position is out of the map' do
      let(:map) do
        ['.#..^.....',
         '........#.',
         '#.........',
         '......#...']
      end

      it 'returns false' do
        expect(resolver.move(map)).to be(false)
      end
    end
  end
end
