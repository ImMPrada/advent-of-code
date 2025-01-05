require 'spec_helper'

RSpec.describe Year2024::Day9::Disk do
  let(:maps) do
    %w[
      2333133121414131402
      12345
      90909
    ]
  end

  describe '#read_map' do
    let(:expected_blocks) do
      [
        [[0, 0],
         %w[. . .],
         [1, 1, 1],
         %w[. . .],
         [2],
         %w[. . .],
         [3, 3, 3],
         %w[.],
         [4, 4],
         %w[.],
         [5, 5, 5, 5],
         %w[.],
         [6, 6, 6, 6],
         %w[.],
         [7, 7, 7],
         %w[.],
         [8, 8, 8, 8],
         [9, 9]],
        [[0], %w[. .], [1, 1, 1], %w[. . . .], [2, 2, 2, 2, 2]],
        [[0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1, 1], [2, 2, 2, 2, 2, 2, 2, 2, 2]]
      ]
    end

    it 'returns the correct disk read' do
      maps.each_with_index do |map, index|
        disk = described_class.new(map)
        disk.read_map
        expect(disk.blocks).to eq(expected_blocks[index])
      end
    end
  end

  describe '#move_filled_block' do
    let(:expected_blocks) do
      [
        [[0, 0],
         [9, 9, '.'],
         [1, 1, 1],
         %w[. . .],
         [2],
         %w[. . .],
         [3, 3, 3],
         %w[.],
         [4, 4],
         %w[.],
         [5, 5, 5, 5],
         %w[.],
         [6, 6, 6, 6],
         %w[.],
         [7, 7, 7],
         %w[.],
         [8, 8, 8, 8],
         %w[. .]],
        [[0], [2, 2], [1, 1, 1], [2, 2, 2, '.'], %w[. . . . .]],
        [[0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1, 1], [2, 2, 2, 2, 2, 2, 2, 2, 2]]
      ]
    end

    it 'updates the correct disk read' do
      maps.each_with_index do |map, index|
        disk = described_class.new(map)
        disk.read_map
        disk.move_filled_block
        expect(disk.blocks).to eq(expected_blocks[index])
      end
    end
  end

  describe '#move_all_filled_blocks' do
    let(:expected_blocks) do
      [
        [[0, 0],
         [9, 9, 8],
         [1, 1, 1],
         [8, 8, 8],
         [2],
         [7, 7, 7],
         [3, 3, 3],
         [6],
         [4, 4],
         [6],
         [5, 5, 5, 5],
         [6],
         [6, '.', '.', '.'],
         %w[.],
         %w[. . .],
         %w[.],
         %w[. . . .],
         %w[. .]],
        [[0], [2, 2], [1, 1, 1], [2, 2, 2, '.'], %w[. . . . .]],
        [[0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1, 1], [2, 2, 2, 2, 2, 2, 2, 2, 2]]
      ]
    end

    let(:expected_strings) do
      %w[
        0099811188827773336446555566..............
        022111222......
        000000000111111111222222222
      ]
    end

    it 'updates the correct disk read' do
      maps.each_with_index do |map, index|
        disk = described_class.new(map)
        disk.read_map
        disk.move_all_filled_blocks
        expect(disk.blocks.flatten.join).to eq(expected_strings[index])
      end
    end
  end

  describe '#check_sum' do
    let(:expected_results) do
      [
        1928,
        60,
        513
      ]
    end

    it 'updates the correct disk read' do
      maps.each_with_index do |map, index|
        disk = described_class.new(map)
        disk.read_map
        disk.move_all_filled_blocks
        disk.check_sum
        expect(disk.check_sum).to eq(expected_results[index])
      end
    end
  end
end
