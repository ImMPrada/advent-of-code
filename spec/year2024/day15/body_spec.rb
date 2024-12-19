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
end
