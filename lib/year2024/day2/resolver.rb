module Year2024
  module Day2
    class Resolver
      FILE_PATH = 'lib/year2024/day1/input.txt'.freeze

      attr_reader :file_content

      def initialize(path = nil)
        file_content = File.read(path || FILE_PATH)
        @file_content = file_content
      end
    end
  end
end
