require 'spec_helper'

RSpec.describe Year2024::Day21::RemoteControl do
  subject(:remote) do
    described_class.new([
                          [7, 8, 9],
                          [4, 5, 6],
                          [1, 2, 3],
                          [nil, 0, 'A']
                        ])
  end

  describe '#position_of' do
    it 'finds position of numeric buttons' do
      expect(remote.position_of(5)).to eq([1, 1])
    end

    it 'finds position of letter buttons' do
      expect(remote.position_of('A')).to eq([2, 3])
    end

    it 'returns nil for non-existent buttons' do
      expect(remote.position_of('B')).to be_nil
    end
  end

  describe '#button_at' do
    it 'returns button at valid positions' do
      expect(remote.button_at(2, 3)).to eq('A')
    end

    it 'returns nil for empty positions' do
      expect(remote.button_at(0, 3)).to be_nil
    end

    context 'when out of bounds' do
      let(:out_of_bounds_positions) do
        [
          [3, 0],
          [0, 4],
          [-1, 0]
        ]
      end

      it 'returns nil for out of bounds positions' do
        out_of_bounds_positions.each do |x, y|
          expect(remote.button_at(x, y)).to be_nil
        end
      end
    end
  end

  describe '#valid_position?' do
    it 'returns true for positions with buttons' do
      expect(remote.valid_position?(1, 1)).to be true  # position of 5
    end

    it 'returns false for empty positions' do
      expect(remote.valid_position?(0, 3)).to be false
    end

    context 'when out of bounds' do
      let(:out_of_bounds_positions) do
        [
          [3, 0],
          [0, 4],
          [-1, 0]
        ]
      end

      it 'returns false for out of bounds positions' do
        out_of_bounds_positions.each do |x, y|
          expect(remote.valid_position?(x, y)).to be false
        end
      end
    end
  end

  describe '#find_path_between' do
    context 'when finding path between buttons' do
      it 'returns empty array for same button' do
        expect(remote.find_path_between(5, 5)).to eq([])
      end
    end

    context 'when buttons are adjacent' do
      let(:adjacent_buttons) do
        [
          [5, 2],
          [5, 4],
          [5, 6],
          [5, 8]
        ]
      end

      let(:expected_path) do
        [
          ['v'],
          ['<'],
          ['>'],
          ['^']
        ]
      end

      it 'finds direct path between adjacent buttons' do
        adjacent_buttons.each_with_index do |buttons, index|
          expect(remote.find_path_between(*buttons)).to eq(expected_path[index])
        end
      end
    end

    context 'when buttons are not adjacent' do
      let(:non_adjacent_buttons) do
        [
          [5, 'A'],
          ['A', 5]
        ]
      end

      let(:expected_path) do
        [
          ['v', 'v', '>'],
          ['^', '^', '<']
        ]
      end

      it 'finds path between non-adjacent buttons' do
        non_adjacent_buttons.each_with_index do |buttons, index|
          expect(remote.find_path_between(*buttons)).to eq(expected_path[index])
        end
      end
    end
  end
end
