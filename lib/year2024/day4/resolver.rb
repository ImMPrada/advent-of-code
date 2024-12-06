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

      def run_case2
        target_word = 'MAS'
        row = 0
        col = 0
        count = 0

        while row < puzzle.row_count - 2
          while col < puzzle.column_count - 2
            puzzle_window = Matrix.build(3, 3) { |r, c| puzzle[row + r, col + c] }
            found_count = find_word(puzzle_window, target_word, x_path: true).size
            count += found_count if found_count == 2
            col += 1
          end

          row += 1
          col = 0
        end

        count / 2
      end

      def find_word(input_puzzle, word, x_path: false)
        first_letter = word[0]
        all_words_starting_with_first_letter = []

        input_puzzle.each_with_index do |letter, row, col|
          next unless letter == first_letter

          words = build_words(input_puzzle, row, col, word.size, x_path:)
          all_words_starting_with_first_letter += words
        end

        all_words_starting_with_first_letter.select { |w| w == word }
      end

      def build_words(input_puzzle, row, col, letters_count, x_path: false)
        words = []
        index_offset = letters_count - 1
        movements = build_movements(row, col, index_offset, input_puzzle, x_path)

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

      def build_movements(row, col, index_offset, input_puzzle, x_path)
        movements = []

        movements << CardinalMovement.northen(row, col, index_offset, input_puzzle) unless x_path
        movements << CardinalMovement.north_western(row, col, index_offset, input_puzzle)
        movements << CardinalMovement.western(row, col, index_offset, input_puzzle) unless x_path
        movements << CardinalMovement.south_western(row, col, index_offset, input_puzzle)
        movements << CardinalMovement.southern(row, col, index_offset, input_puzzle) unless x_path
        movements << CardinalMovement.south_eastern(row, col, index_offset, input_puzzle)
        movements << CardinalMovement.eastern(row, col, index_offset, input_puzzle) unless x_path
        movements << CardinalMovement.north_eastern(row, col, index_offset, input_puzzle)

        movements
      end
    end
  end
end
