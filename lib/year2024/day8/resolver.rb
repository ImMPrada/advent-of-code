require './lib/year2024/day8/antenna'
require './lib/year2024/day8/map_reader'

module Year2024
  module Day8
    class Resolver
      FILE_PATH = 'lib/year2024/day8/input.txt'.freeze

      attr_reader :antennas, :map_reader

      def initialize(path = nil)
        @file_path = path || FILE_PATH
        @antennas = []
        @map_reader = []

        read_map
        locate_antennas
        link_antennas
      end

      def run_case1
        antinodes_positions = []
        antennas.each do |antenna|
          antenna.add_projected_antinodes(map_reader)
          antinodes_positions << antenna.antinodes_positions
        end

        antinodes_positions.flatten(1).map(&:to_a).uniq.size
      end

      private

      attr_reader :file_path

      def read_map
        file_content = File.read(file_path)
        @map_reader = MapReader.new(file_content.split("\n"))
      end

      def locate_antennas
        map_reader.read_map.each_with_index do |row, row_index|
          row.each_char.with_index do |map_cell, col_index|
            antennas << Antenna.new(row_index, col_index, map_cell) if map_cell.match?(Antenna::FREQUENCY_REGEX)
          end
        end
      end

      def link_antennas
        antennas.each do |antenna|
          antennas.each do |other_antenna|
            next if other_antenna == antenna

            antenna.link(other_antenna)
          end

          puts "#{antenna.value} : #{antenna.linked_antennas.size} --- #{antenna.linked_antennas.map(&:value)}"
        end
      end
    end
  end
end
