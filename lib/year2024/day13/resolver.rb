require_relative 'point'
require_relative 'button'

module Year2024
  module Day13
    class Resolver
      FILE_PATH = 'lib/year2024/day13/input.txt'.freeze

      attr_reader :machines

      def initialize(path = nil)
        file_path = path || FILE_PATH
        @machines = []

        parse_input(File.readlines(file_path).map(&:chomp))
      end

      def run_case1
        cost = 0

        machines.each do |machine|
          machine_cost = min_cost_for_machine(machine)
          cost += machine_cost unless machine_cost == Float::INFINITY
        end

        cost
      end

      def min_cost_for_machine(machine)
        button_a = machine[:button_a]
        button_b = machine[:button_b]
        prize = machine[:prize]
        min_cost = Float::INFINITY
        max_iterations = 100

        max_iterations.downto(0).each do |iteration_a|
          max_iterations.downto(1).each do |iteration_b|
            resulting_point = iteration_point(button_a, button_b, iteration_a, iteration_b)
            next unless resulting_point == prize

            cost = button_a.cost * iteration_a + button_b.cost * iteration_b
            min_cost = cost if cost < min_cost
          end
        end

        min_cost
      end

      private

      def iteration_point(button_a, button_b, iteration_a, iteration_b)
        x_coord = button_a.x_offset * iteration_a + button_b.x_offset * iteration_b
        y_coord = button_a.y_offset * iteration_a + button_b.y_offset * iteration_b

        Point.new(x_coord:, y_coord:)
      end

      def parse_input(lines)
        current_machine = {}

        lines.each do |line|
          next if line.empty?

          case line
          when /Button A: X\+(\d+), Y\+(\d+)/
            add_button_a(current_machine, ::Regexp.last_match(1).to_i, ::Regexp.last_match(2).to_i)
          when /Button B: X\+(\d+), Y\+(\d+)/
            add_button_b(current_machine, ::Regexp.last_match(1).to_i, ::Regexp.last_match(2).to_i)
          when /Prize: X=(\d+), Y=(\d+)/
            add_prize(current_machine, ::Regexp.last_match(1).to_i, ::Regexp.last_match(2).to_i)

            @machines << current_machine
            current_machine = {}
          end
        end
      end

      def add_button_a(machine, x_offset, y_offset)
        machine[:button_a] = Button.create_button_a(x_offset:, y_offset:)
      end

      def add_button_b(machine, x_offset, y_offset)
        machine[:button_b] = Button.create_button_b(x_offset:, y_offset:)
      end

      def add_prize(machine, x_coord, y_coord)
        machine[:prize] = Point.new(x_coord:, y_coord:)
      end
    end
  end
end
