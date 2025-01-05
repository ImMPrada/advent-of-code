require_relative 'path_traversable'
require 'fileutils'

module Year2024
  module Day20
    class Resolver
      include PathTraversable

      FILE_PATH = 'lib/year2024/day20/input.txt'.freeze

      attr_reader :grid, :height, :width, :start, :end

      def initialize(path = nil)
        file_path = path || FILE_PATH
        lines = File.readlines(file_path).map(&:chomp)

        @grid = parse_grid(lines)
        @height = grid.size
        @width = grid[0].size
        @start = find_position('S')
        @end = find_position('E')

        puts "Grid size: #{width}x#{height}"
        puts "Start: #{start}, End: #{self.end}"
      end

      def run_case1
        puts "\e[31mfinding shortest base path...\e[0m"
        sleep 0.5
        base_time = find_shortest_path(start, self.end)
        puts "\e[31mBase time without cheating: #{base_time}\e[0m"
        sleep 1

        puts "\e[33mfinding possible cheats....\e[0m"
        cheats = find_all_cheats
        puts "\e[32m\nFound #{cheats.size} possible cheats\n\e[0m"
        sleep 1

        savings = group_cheats_by_time_saved(cheats, base_time)
        savings.sort.each do |time, count|
          puts "\e[32m#{count} cheats save #{time} picoseconds\e[0m"
        end

        savings.sum { |time, count| time >= 100 ? count : 0 }
      end

      private

      def group_cheats_by_time_saved(cheats, base_time)
        savings = Hash.new(0)
        cheats.each do |cheat|
          time_saved = base_time - cheat[:time]
          savings[time_saved] += 1 if time_saved.positive?
        end

        savings
      end

      def parse_grid(lines)
        lines.map(&:chars)
      end

      def find_position(char)
        grid.each_with_index do |row, y|
          row.each_with_index do |cell, x|
            return [x, y] if cell == char
          end
        end
      end
    end
  end
end
