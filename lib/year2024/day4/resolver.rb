require 'matrix'
require './lib/year2024/day4/cardinal_movement'

module Year2024
  module Day4
    class Resolver
      FILE_PATH = 'lib/year2024/day4/input.txt'.freeze

      attr_reader :file_content, :puzzle

      def initialize(path = nil)
        file_content = File.read(path || FILE_PATH)
        file_read = []

        file_content.each_line do |line_i|
          row = line_i.chars.reject { |c| c == "\n" }
          file_read << row
        end

        @puzzle = Matrix.build(file_read.size, file_read[0].size) { |row, col| file_read[row][col] }
        @file_content = file_content
      end

      def run_case1
        target_word = 'XMAS'
        find_word(puzzle, target_word).size
      end

      def find_word(input_puzzle, word, selected_movements = nil)
        first_letter = word[0]
        all_words_starting_with_first_letter = []

        input_puzzle.each_with_index do |letter, row, col|
          next unless letter == first_letter

          words = build_words(input_puzzle, row, col, word.size, selected_movements)
          all_words_starting_with_first_letter += words
        end

        all_words_starting_with_first_letter.select { |w| w == word }
      end

      def build_words(input_puzzle, row, col, letters_count, selected_movements = nil)
        words = []
        index_offset = letters_count - 1
        movements = selected_movements || [
          CardinalMovement.northen(row, col, index_offset, input_puzzle),
          CardinalMovement.north_western(row, col, index_offset, input_puzzle),
          CardinalMovement.western(row, col, index_offset, input_puzzle),
          CardinalMovement.south_western(row, col, index_offset, input_puzzle),
          CardinalMovement.southern(row, col, index_offset, input_puzzle),
          CardinalMovement.south_eastern(row, col, index_offset, input_puzzle),
          CardinalMovement.eastern(row, col, index_offset, input_puzzle),
          CardinalMovement.north_eastern(row, col, index_offset, input_puzzle)
        ]

        movements.each do |movement|
          movement.compute_limits
          word = build_word(input_puzzle, row, col, movement)
          words << word if word.size == letters_count
        end

        words
      end

      private

      def build_word(input_puzzle, row, col, cardinal_movement)
        word = ''

        scraping_row = row
        scraping_col = col

        while cardinal_movement.can_move_to?(scraping_row, scraping_col)
          word += input_puzzle[scraping_row, scraping_col]
          scraping_row, scraping_col = cardinal_movement.next_position(scraping_row, scraping_col)
        end

        word
      end
    end
  end
end
