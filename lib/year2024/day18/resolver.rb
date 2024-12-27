require_relative 'memory_space'

module Year2024
  module Day18
    class Resolver
      FILE_PATH = 'lib/year2024/day18/input.txt'.freeze

      def initialize(path = nil)
        file_path = path || FILE_PATH
        lines = File.readlines(file_path).map(&:chomp)
        @bytes = parse_bytes(lines)
      end

      def run_case1
        memory = MemorySpace.new(size: 71)

        @bytes.take(1024).each do |x, y|
          memory.corrupt(x, y)
        end

        memory.find_shortest_path
      end

      private

      def parse_bytes(lines)
        lines.map do |line|
          x, y = line.split(',').map(&:to_i)
          [x, y]
        end
      end
    end
  end
end
