require_relative 'remote_control'

module Year2024
  module Day21
    class Resolver
      FILE_PATH = 'lib/year2024/day21/input.txt'.freeze

      def initialize(path = nil)
        file_path = path || FILE_PATH
        @codes = File.readlines(file_path).map(&:chomp)
        @door_control = RemoteControl.new(
          [
            [7, 8, 9],
            [4, 5, 6],
            [1, 2, 3],
            [nil, 0, 'A']
          ]
        )
      end

      def run_case1
        # TODO: Implement case 1
      end
    end
  end
end
