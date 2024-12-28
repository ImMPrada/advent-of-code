module Year2024
  module Day21
    class Resolver
      FILE_PATH = 'lib/year2024/day21/input.txt'.freeze

      NUMERIC_KEYPAD = {
        '7' => [0, 0], '8' => [1, 0], '9' => [2, 0],
        '4' => [0, 1], '5' => [1, 1], '6' => [2, 1],
        '1' => [0, 2], '2' => [1, 2], '3' => [2, 2],
        '0' => [1, 3], 'A' => [2, 3]
      }.freeze

      def initialize(path = nil)
        file_path = path || FILE_PATH
        @codes = File.readlines(file_path).map(&:chomp)
      end

      def run_case1
        @codes.sum do |code|
          sequence = find_shortest_sequence(code)
          numeric_value = code.to_i
          complexity = sequence.length * numeric_value
          
          puts "Code: #{code}"
          puts "Sequence length: #{sequence.length}"
          puts "Numeric value: #{numeric_value}"
          puts "Complexity: #{complexity}"
          puts "---"
          
          complexity
        end
      end

      private

      def find_shortest_sequence(code)
        # Start at 'A' position
        current = NUMERIC_KEYPAD['A']
        sequence = []

        code.each_char do |target_char|
          target = NUMERIC_KEYPAD[target_char]
          path = find_path(current, target)
          sequence += path
          sequence << 'A' # Add activation
          current = target
        end

        sequence.join
      end

      def find_path(from, to)
        queue = [[from, []]] # [position, path]
        visited = Set.new([from])

        while queue.any?
          pos, path = queue.shift
          return path if pos == to

          moves = possible_moves(pos)
          moves.each do |direction, next_pos|
            next if visited.include?(next_pos)
            next unless valid_position?(next_pos)

            visited.add(next_pos)
            queue << [next_pos, path + [direction]]
          end
        end

        raise "No path found from #{from} to #{to}"
      end

      def possible_moves(pos)
        x, y = pos
        {
          '^' => [x, y - 1],
          'v' => [x, y + 1],
          '<' => [x - 1, y],
          '>' => [x + 1, y]
        }
      end

      def valid_position?(pos)
        NUMERIC_KEYPAD.values.include?(pos)
      end
    end
  end
end
