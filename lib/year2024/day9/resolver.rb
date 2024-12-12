require_relative 'disk'

module Year2024
  module Day9
    class Resolver
      FILE_PATH = 'lib/year2024/day9/input.txt'.freeze

      attr_reader :disk

      def initialize(path = nil)
        @file_path = path || FILE_PATH
        @disk = Disk.new(File.read(file_path).split("\n").first)
      end

      def run_case1
        disk.read_map
        disk.move_all_filled_blocks
        disk.check_sum
      end

      def run_case2
        disk.read_map
        disk.move_all_filled_blocks(fragmented: false)
        disk.check_sum
      end

      private

      attr_reader :file_path
    end
  end
end
