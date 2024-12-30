require 'spec_helper'

RSpec.describe Year2024::Day21::Resolver do
  subject(:resolver) { described_class.new(file_path) }

  let(:file_path) { 'spec/year2024/day21/input.txt' }

  describe '#run_case1' do
    it 'returns the sum of complexities for all codes' do
      expect(resolver.run_case1).to eq(126_384)
    end
  end

  describe '#build_sequence' do
    it 'creates pairs of consecutive buttons from code' do
      code = '029A'
      expected_sequence = [%w[A 0], %w[0 2], %w[2 9], %w[9 A]]

      expect(resolver.send(:build_sequence, code)).to eq(expected_sequence)
    end
  end

  describe '#build_instructions' do
    let(:sequence) { [%w[A 0], %w[0 2], %w[2 9], %w[9 A]] }
    let(:control) { resolver.instance_variable_get(:@door_control) }
    let(:expected_instructions) do
      [
        %w[< A ^ A > ^ ^ A v v v A],
        %w[< A ^ A ^ > ^ A v v v A],
        %w[< A ^ A ^ ^ > A v v v A]
      ]
    end
    let(:instructions) { resolver.send(:build_instructions, sequence, control) }

    it 'builds path instructions for the sequence' do
      expect(expected_instructions.include?(instructions)).to be(true)
    end

    it 'returns a valid moves instructions' do
      expect(instructions).to all(match(/^[<>v^A]$/))
    end
  end

  describe '#last_robot_code_for' do
    let(:code) { '029A' }
    let(:expected_code) { '<vA<AA>>^AvAA<^A>A<v<A>>^AvA^A<vA>^A<v<A>^A>AAvA^A<v<A>A>^AAAvA<^A>A' }

    it 'returns the last robot code for the given code' do
      expect(resolver.send(:last_robot_code_for, code)).to eq(expected_code)
    end
  end
end
