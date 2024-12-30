require_relative 'disk'

module Year2024
  module Day9
    class Resolver
      FILE_PATH = 'lib/year2024/day9/input.txt'.freeze

      attr_reader :disk, :blocks, :file_sizes, :file_locations

      def initialize(path = nil)
        @file_path = path || FILE_PATH
        input = File.read(file_path).split("\n").first
        @disk = Disk.new(input)

        @blocks = []
        @file_sizes = []
        @file_locations = []
      end

      def run_case1
        disk.read_map
        disk.move_all_filled_blocks(fragmented: true)
        disk.check_sum
      end

      def run_case2
        puts 'Starting part 2 (compacted moves)...'
        puts 'Making filesystem...'
        make_filesystem
        puts "Initial state: #{visualize(@blocks)}"

        puts "\nMoving files..."
        moved = move_files

        puts "\nFinal state: #{visualize(moved)}"
        result = calculate_checksum(moved)
        puts "Checksum: #{result}"
        result
      end

      private

      attr_reader :file_path

      def make_filesystem
        is_file = true
        id = 0

        disk.map.each_char do |x|
          x = x.to_i
          if is_file
            @file_locations[id] = @blocks.size
            @file_sizes[id] = x
            @blocks.concat([id] * x)
            id += 1
            is_file = false
          else
            @blocks.concat([nil] * x)
            is_file = true
          end
        end

        @blocks
      end

      def move_files
        big = 0
        big += 1 while @file_sizes[big].to_i.positive?
        big -= 1

        puts "Processing files from ID #{big} down to 0"

        big.downto(0) do |to_move|
          puts "  Moving file #{to_move}..."
          move_file(to_move)
          puts "  Current state: #{visualize(@blocks)}"
        end

        @blocks
      end

      def move_file(to_move)
        first_free = find_suitable_free_space(to_move)
        return if first_free >= @file_locations[to_move]

        (first_free...(first_free + @file_sizes[to_move])).each do |idx|
          @blocks[idx] = to_move
        end
        (@file_locations[to_move]...(@file_locations[to_move] + @file_sizes[to_move])).each do |idx|
          @blocks[idx] = nil
        end
      end

      def find_suitable_free_space(file_id)
        free_space = 0
        first_free = 0

        while first_free < @file_locations[file_id] && free_space < @file_sizes[file_id]
          first_free += free_space
          free_space = 0

          first_free += 1 while first_free < @blocks.size && !@blocks[first_free].nil?
          free_space += 1 while first_free + free_space < @blocks.size && @blocks[first_free + free_space].nil?
        end

        first_free
      end

      def calculate_checksum(arr)
        sum = 0
        arr.each_with_index do |x, i|
          sum += i * x unless x.nil?
        end
        sum
      end

      def visualize(arr)
        arr.map { |block| block.nil? ? '.' : block }.join
      end
    end
  end
end
