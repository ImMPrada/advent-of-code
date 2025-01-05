module Year2024
  module Day11
    module Loggable
      COLORS = {
        yellow: "\e[33m",
        green: "\e[32m",
        cyan: "\e[36m",
        reset: "\e[0m"
      }.freeze

      def display_initial_stones
        puts "#{COLORS[:yellow]}Starting with #{stones.to_a.size} stones:#{COLORS[:reset]}"
        puts "Initial stones: #{stones.to_a.inspect}"
      end

      def display_stones_progress(iteration)
        puts "#{COLORS[:cyan]}After #{iteration} blinks: #{stones.to_a.size} stones#{COLORS[:reset]}"
        puts "Current stones: #{stones.to_a.inspect}" if (iteration % 10).zero?
      end

      def display_final_stones
        puts "#{COLORS[:green]}Final stone count: #{stones.to_a.size}#{COLORS[:reset]}"
        puts "Final stones: #{stones.to_a.inspect}"
      end

      def display_initial_state(nums)
        puts "#{COLORS[:yellow]}Starting with #{nums.values.sum} stones:#{COLORS[:reset]}"
        puts nums.inspect
      end

      def display_progress(nums, iteration)
        puts "#{COLORS[:cyan]}After #{iteration} blinks: #{nums.values.sum} stones#{COLORS[:reset]}"
      end

      def display_final_count(nums)
        total = nums.values.sum
        puts "#{COLORS[:green]}Final count: #{total} stones#{COLORS[:reset]}"
      end
    end
  end
end
