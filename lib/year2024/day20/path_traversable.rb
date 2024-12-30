module Year2024
  module Day20
    module PathTraversable
      def find_shortest_path(start, target)
        queue = [[start, 0]] # [position, steps]
        visited = Set.new([start])

        while queue.any?
          pos, steps = queue.shift
          return steps if pos == target

          neighbors(*pos).each do |next_pos|
            next if visited.include?(next_pos)
            next unless valid_move?(*next_pos)

            visited.add(next_pos)
            queue << [next_pos, steps + 1]
          end
        end

        Float::INFINITY
      end

      def find_all_cheats
        cheats = []
        processed = Set.new
        puts "\e[33mworking on it...\e[0m"

        (0...height).each do |y|
          puts "\e[33m  #{(y * 100.0 / height).round(2)}%\e[0m"
          (0...width).each do |x|
            next unless valid_move?(x, y)

            neighbors(x, y).each do |next_pos|
              process_neighbors(x, y, processed, cheats, next_pos)
            end
          end
        end

        cheats
      end

      def calculate_path_with_cheat(cheat_start, cheat_end, cheat_length)
        to_cheat = find_shortest_path(start, cheat_start)
        from_cheat = find_shortest_path(cheat_end, self.end)

        return Float::INFINITY if to_cheat == Float::INFINITY || from_cheat == Float::INFINITY

        to_cheat + cheat_length + from_cheat
      end

      private

      def process_neighbors(x_coord, y_coord, processed, cheats, next_pos)
        next_pos_neighbors = neighbors(*next_pos)

        next_pos_neighbors.each do |end_pos|
          next unless valid_move?(*end_pos)

          cheat_key = [[x_coord, y_coord], end_pos]
          next if processed.include?(cheat_key)

          process_cheat(x_coord, y_coord, end_pos, processed, cheat_key, cheats)
        end
      end

      def process_cheat(x_coord, y_coord, end_pos, processed, cheat_key, cheats)
        processed.add(cheat_key)
        time = calculate_path_with_cheat([x_coord, y_coord], end_pos, 2)
        cheats << { start: [x_coord, y_coord], end: end_pos, time: }
      end

      def neighbors(x_coord, y_coord)
        [
          [x_coord + 1, y_coord],
          [x_coord - 1, y_coord],
          [x_coord, y_coord + 1],
          [x_coord, y_coord - 1]
        ].select { |nx, ny| in_bounds?(nx, ny) }
      end

      def in_bounds?(x_coord, y_coord)
        x_coord >= 0 && x_coord < width && y_coord >= 0 && y_coord < height
      end

      def valid_move?(x_coord, y_coord)
        grid[y_coord][x_coord] != '#'
      end
    end
  end
end
