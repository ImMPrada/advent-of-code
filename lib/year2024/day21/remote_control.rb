module Year2024
  module Day21
    class RemoteControl
      attr_reader :buttons, :a_position

      def initialize(buttons)
        @buttons = buttons
        @a_position = position_of('A')
      end

      def position_of(button)
        buttons.each_with_index do |row, y|
          row.each_with_index do |value, x|
            return [x, y] if value == button
          end
        end
        nil
      end

      def button_at(x, y)
        return nil unless y.between?(0, 3) && x.between?(0, 2)

        buttons[y][x]
      end

      def valid_position?(x, y)
        button_at(x, y) != nil
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

      def find_path_between(from_button, to_button)
        from_pos = position_of(from_button)
        to_pos = position_of(to_button)

        return [] if from_pos == to_pos

        queue = [[from_pos, []]] # [position, path]
        visited = Set.new([from_pos])

        while queue.any?
          pos, path = queue.shift
          return path if pos == to_pos

          possible_moves(pos).each do |direction, next_pos|
            next if visited.include?(next_pos)
            next unless valid_position?(*next_pos)

            visited.add(next_pos)
            queue << [next_pos, path + [direction]]
          end
        end

        raise "No path found from #{from_button} to #{to_button}"
      end
    end
  end
end
