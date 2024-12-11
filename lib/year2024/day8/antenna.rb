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

      def add_projected_antinodes(map_reader, enable_resonance: false)
        linked_antennas.each do |antenna|
          add_antinode(antenna, map_reader, enable_resonance)
        end

        puts "Value: #{value} -- #{position.to_a} : Antinodes: #{antinodes_positions.map(&:to_a)}"
      end

      private

      def add_antinode(antenna, map_reader, enable_resonance)
        antinode_position = project_antinode_to(antenna.position)
        vector = vector_to(antenna.position)
        map_reader.out_of_bounds?(antinode_position)

        return if map_reader.out_of_bounds?(antinode_position)

        antinodes_positions << antinode_position
        add_antinode_to_resonance(map_reader, vector, antinode_position) if enable_resonance
      end

      def project_antinode_to(antenna_position)
        vector = vector_to(antenna_position)
        antenna_position + vector
      end

      def vector_to(antenna_position)
        antenna_position - position
      end

      def add_antinode_to_resonance(map_reader, vector, antinode_position)
        puts 'RESONANCE....'

        loop do
          antinode_position += vector
          out_of_bounds = map_reader.out_of_bounds?(antinode_position)
          puts "New antinode position: #{antinode_position.to_a} -- Out of bounds: #{out_of_bounds}"
          break if out_of_bounds

          antinodes_positions << antinode_position
        end
      end
    end
  end
end
