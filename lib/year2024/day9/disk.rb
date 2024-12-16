require_relative 'no_more_blocks_error'

module Year2024
  module Day9
    class Disk # rubocop:disable Metrics/ClassLength
      FREE_SPACE = '.'.freeze

      attr_reader :map, :file_id, :empty_blocks_indexes, :filled_blocks_indexes, :blocks

      def initialize(map)
        @map = map
        @file_id = 0
        @empty_blocks_indexes = []
        @filled_blocks_indexes = []
        @blocks = []
      end

      def read_map
        puts 'reading map...'
        is_empty_block = false

        map.chars do |value|
          unless is_empty_block
            add_file_id(value)
            is_empty_block = !is_empty_block
            next
          end

          add_empty_blocks(value)
          is_empty_block = !is_empty_block
        end

        puts 'Done! results:'
        puts "blocks: #{blocks}"
        puts "empty_blocks_indexes: #{empty_blocks_indexes}"
        puts "filled_blocks_indexes: #{filled_blocks_indexes}"
      end

      def move_all_filled_blocks(fragmented: true)
        puts 'moving all filled blocks...'
        string = stringify_blocks

        loop do
          puts "string: #{string}"
          break if ready?(string)

          move_filled_block(fragmented:)

          string = stringify_blocks
        rescue NoMoreBlocksError
          puts 'No more blocks to move'
          break
        end

        puts 'Done!'
      end

      def move_filled_block(fragmented: true)
        return if empty_blocks_indexes.empty?
        return fragmented_move_filled_block if fragmented

        compacted_move_filled_block
      end

      def check_sum
        puts 'checking sum...'
        sum = 0
        index = 0

        blocks.each do |block|
          block.each do |value|
            next if value == FREE_SPACE

            sum += value * index
            index += 1
          end
        end

        sum
      end

      private

      def fragmented_move_filled_block
        run_moving_filled_blocks_loop
        filled_blocks_indexes.pop
      end

      def compacted_move_filled_block
        filled_block_index = filled_blocks_indexes.pop
        raise NoMoreBlocksError if filled_block_index.nil?

        filled_block = blocks[filled_block_index]

        empty_blocks_indexes.each do |empty_block_index|
          break if empty_block_index >= filled_block_index

          empty_block = blocks[empty_block_index]
          next unless block_fits_in_block?(filled_block, empty_block)

          fill_empty_block(filled_block, empty_block)
        end
      end

      def add_file_id(value)
        filled_blocks_indexes << blocks.size
        file_block = []
        value.to_i.times { file_block << file_id }

        @file_id += 1
        blocks << file_block
      end

      def add_empty_blocks(value)
        empty_block = []
        value.to_i.times { empty_block << FREE_SPACE }
        return if empty_block.empty?

        empty_blocks_indexes << blocks.size
        blocks << empty_block
      end

      def empty_block_with_index
        empty_block_index = empty_blocks_indexes.first
        empty_block = blocks[empty_block_index]

        [empty_block, empty_block.index(FREE_SPACE), empty_block_index]
      end

      def last_filled_block
        filled_block_index = filled_blocks_indexes.last
        [filled_block_index, blocks[filled_block_index]]
      end

      def run_moving_filled_blocks_loop
        empty_block, empty_index, empty_block_index = empty_block_with_index
        filled_block_index, filled_block = last_filled_block

        file_index = -1
        file = filled_block[file_index]

        until file.nil?
          swap_file_to_empty_block(empty_block, empty_index, filled_block, file_index, file)

          file_index -= 1
          file = filled_block[file_index]

          empty_index = empty_block.index(FREE_SPACE)
          next unless empty_index.nil?
          break if empty_block_index + 1 >= filled_block_index

          empty_blocks_indexes.shift
          empty_block, empty_index, empty_block_index = empty_block_with_index
        end

        empty_blocks_indexes.push(filled_block_index)
      end

      def swap_file_to_empty_block(empty_block, empty_index, filled_block, file_index, file)
        empty_block[empty_index] = file
        filled_block[file_index] = FREE_SPACE
      end

      def stringify_blocks
        blocks.flatten.join
      end

      def ready?(string_blocks)
        string_blocks.match?(/^\d+\.+$/) || string_blocks.match?(/^\d+$/)
      end

      def block_fits_in_block?(block_a, block_b)
        block_b.count(FREE_SPACE) >= block_a.size
      end

      def fill_empty_block(block_a, empty_block)
        empty_block_index = empty_block.index(FREE_SPACE)

        block_a.each_with_index do |value, index|
          empty_block[empty_block_index] = value
          block_a[index] = FREE_SPACE

          empty_block_index += 1
        end
      end
    end
  end
end
