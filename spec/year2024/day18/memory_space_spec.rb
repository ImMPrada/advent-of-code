require 'spec_helper'

RSpec.describe Year2024::Day18::MemorySpace do
  subject(:memory) { described_class.new(size: 7) }

  describe '#corrupt' do
    it 'marks the specified position as corrupted' do
      memory.corrupt(3, 4)
      expect(memory.send(:valid_move?, 3, 4)).to be false
    end
  end

  describe '#find_shortest_path' do
    context 'with example from problem' do
      before do
        [
          [5, 4], [4, 2], [4, 5], [3, 0],
          [2, 1], [6, 3], [2, 4], [1, 5],
          [0, 6], [3, 3], [2, 6], [5, 1]
        ].each { |x, y| memory.corrupt(x, y) }
      end

      it 'finds the shortest path length' do
        expect(memory.find_shortest_path).to eq(22)
      end
    end

    context 'when path is blocked' do
      before { (0..6).each { |y| memory.corrupt(3, y) } }

      it 'returns nil when no path exists' do
        expect(memory.find_shortest_path).to be_nil
      end
    end
  end
end
