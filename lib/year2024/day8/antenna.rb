require_relative 'position'

module Year2024
  module Day8
    class Antenna
      attr_reader :position, :value, :linked_antennas, :antinodes_positions

      FREQUENCY_REGEX = /[a-zA-Z0-9]/

      def initialize(row_index, col_index, value)
        @position = Position.new(row_index, col_index)
        @value = value
        @linked_antennas = []
        @antinodes_positions = []
      end

      def link(antenna)
        return unless antenna.value == value

        linked_antennas << antenna
      end

      def add_projected_antinodes(map_reader)
        linked_antennas.each do |antenna|
          add_antinode(antenna, map_reader)
        end

        puts "Value: #{value} -- #{position.to_a} : Antinodes: #{antinodes_positions.map(&:to_a)}"
      end

      private

      def add_antinode(antenna, map_reader)
        antinode_position = project_antinode_to(antenna)
        return if map_reader.out_of_bounds?(antinode_position)

        antinodes_positions << antinode_position
      end

      def project_antinode_to(antenna)
        vector = vector_to(antenna)
        antenna.position + vector
      end

      def vector_to(antenna)
        antenna.position - position
      end
    end
  end
end
