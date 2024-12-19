require 'spec_helper'

RSpec.describe Year2024::Day15::Body do
  subject(:body) { map.cells.find { |cell| cell.occupant&.symbol == symbol }.occupant }

  let(:map) { Year2024::Day15::Map.new(lines) }

  describe '#can_move?' do
    let(:cell) { map.boxes_cells.first }
    let(:symbol) { Year2024::Day15::Cell::BOX }
    let(:direction) { '>' }

    context 'when the body is free to move' do
      let(:lines) do
        [
          '.O.#.'
        ]
      end

      it 'returns true' do
        expect(body.can_move?(map, direction)).to be(true)
      end
    end

    context 'when the body is blocked by a wall' do
      let(:lines) do
        [
          '.O#..'
        ]
      end

      it 'returns false' do
        expect(body.can_move?(map, direction)).to be(false)
      end
    end

    context 'when the body is blocked by a box' do
      let(:lines) do
        [
          '.OO.#'
        ]
      end

      it 'returns true' do
        expect(body.can_move?(map, direction)).to be(true)
      end
    end

    context 'when the body is blocked by a box and the box is blocked by a wall' do
      let(:lines) do
        [
          '.OO#.'
        ]
      end

      it 'returns false' do
        expect(body.can_move?(map, direction)).to be(false)
      end
    end
  end

  describe '#move' do
    let(:cell) { map.boxes_cells.first }
    let(:symbol) { Year2024::Day15::Cell::BOX }
    let(:direction) { '>' }

    context 'when the body is free to move .O.#.' do
      let(:lines) do
        [
          '.O.#.'
        ]
      end

      it 'updates the body cell to the target cell ..O#.' do
        expect(body.move(map, direction).cell.to_a).to eq([2, 0])
      end
    end

    context 'when the body is blocked by a wall .O#..' do
      let(:lines) do
        [
          '.O#..'
        ]
      end

      it 'returns nil' do
        expect(body.move(map, direction)).to be_nil
      end
    end

    context 'when the body is blocked by a box .OO.#' do
      let(:lines) do
        [
          '.OO.#'
        ]
      end

      it 'updates both bodies cells ..OO#' do
        body.move(map, direction)
        expect(map.cells.select { |cell| cell.occupant&.symbol == symbol }.map(&:to_a)).to eq([[2, 0], [3, 0]])
      end
    end

    context 'when the body is blocked by a box and the box is blocked by a wall' do
      let(:lines) do
        [
          '.OO#.'
        ]
      end

      it 'returns nil' do
        expect(body.move(map, direction)).to be_nil
      end
    end
  end
end
