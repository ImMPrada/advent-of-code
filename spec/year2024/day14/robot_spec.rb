require 'spec_helper'

RSpec.describe Year2024::Day14::Robot do
  subject(:robot) { described_class.new(cell:, velocity:) }

  let(:map) { Year2024::Day14::Map.new(11, 7) }
  let(:cell) { map[0, 4] }
  let(:velocity) { Year2024::Day14::Velocity.new(x_component: 3, y_component: -3) }

  describe '#move' do
    let(:expected_cell_coords) do
      [
        [3, 1],
        [6, 5],
        [9, 2],
        [1, 6],
        [4, 3],
        [7, 0],
        [10, 4],
        [2, 1],
        [5, 5]
      ]
    end

    it 'moves the robot to the new cell' do
      expected_cell_coords.each do |coords|
        robot.move(map)
        expect(robot.cell.to_a).to eq(coords)
      end
    end
  end
end
