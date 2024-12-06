require 'matrix'

module Year2024
  module Day4
    class Resolver
      FILE_PATH = 'lib/year2024/day4/input.txt'.freeze

      attr_reader :file_content, :puzzle

      def initialize
        file_content = File.read(FILE_PATH)
        file_read = []

        file_content.each_line do |line_i|
          row = line_i.chars
          file_read << row
        end

        @puzzle = Matrix.build(file_read.size, file_read[0].size) { |row, col| file_read[row][col] }
        @file_content = file_content
      end
    end
  end
end
