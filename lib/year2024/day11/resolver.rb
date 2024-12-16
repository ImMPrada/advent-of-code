require_relative 'stone'
require_relative 'stones'
module Year2024
  module Day11
    class Resolver
      FILE_PATH = 'lib/year2024/day11/input.txt'.freeze

      attr_reader :stones

      def initialize(path = nil)
        file_path = path || FILE_PATH
        line = File.readlines(file_path).map(&:chomp)[0]

        build_stones_list(line)
      end

      def run_case1
        run_for(25)
        stones.to_a.size
      end

      def run_case2
        run_for(75)
        stones.to_a.size
      end

      def run_for(blinking_times)
        blinking_times.times do
          stones.blink
        end
      end

      private

      def build_stones_list(line)
        stones_list = []

        line.split(' ').each do |number|
          stones_list << Stone.new(number.to_i)
        end

        @stones = Stones.new(stones_list)
      end
    end
  end
end
