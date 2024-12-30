module Year2024
  module Day12
    module Loggable
      COLORS = {
        yellow: "\e[33m",
        green: "\e[32m",
        cyan: "\e[36m",
        magenta: "\e[35m",
        red: "\e[31m",
        reset: "\e[0m"
      }.freeze

      EMOJIS = {
        search: '🔍',
        found: '✨',
        calculate: '🧮',
        region: '🏰',
        corner: '📐',
        stack: '📚',
        cell: '🟦',
        price: '💰',
        total: '💎',
        build: '🏗️',
        group: '🔄',
        done: '✅'
      }.freeze

      def log_start_search
        puts "#{COLORS[:yellow]}#{EMOJIS[:search]} Starting garden exploration...#{COLORS[:reset]}"
      end

      def log_plot_found(char, size)
        puts "#{COLORS[:cyan]}#{EMOJIS[:found]} Found region #{char} with #{size} cells#{COLORS[:reset]}"
      end

      def log_stack_progress(stack_size)
        return unless (stack_size % 100).zero?

        puts "#{COLORS[:magenta]}#{EMOJIS[:stack]} Processing stack... (#{stack_size} cells remaining)#{COLORS[:reset]}"
      end

      def log_region_price(char, area, perimeter, price)
        puts "#{COLORS[:green]}#{EMOJIS[:region]} Region #{char}:"\
             " #{EMOJIS[:cell]} Area: #{area}"\
             " #{EMOJIS[:corner]} Perimeter: #{perimeter}"\
             " #{EMOJIS[:price]} Price: #{price}#{COLORS[:reset]}"
      end

      def log_total_price(total)
        puts "\n#{COLORS[:yellow]}#{EMOJIS[:total]} Final garden price: #{total}#{COLORS[:reset]}"
      end

      def log_corner_found(i_coord, j_coord, corners)
        return unless (corners % 10).zero?

        puts "#{COLORS[:cyan]}#{EMOJIS[:corner]} Found corner at (#{i_coord},#{j_coord})."
        puts "Total corners: #{corners}#{COLORS[:reset]}"
      end

      def log_calculation_start
        puts "#{COLORS[:magenta]}#{EMOJIS[:calculate]} Calculating garden metrics...#{COLORS[:reset]}"
      end

      def log_error(message)
        puts "#{COLORS[:red]}❌ Error: #{message}#{COLORS[:reset]}"
      end

      def log_build_regions_start
        puts "#{COLORS[:yellow]}#{EMOJIS[:build]} Building garden regions...#{COLORS[:reset]}"
      end

      def log_group_region(name)
        puts "#{COLORS[:cyan]}#{EMOJIS[:group]} Grouping cells for region #{name}#{COLORS[:reset]}"
      end

      def log_regions_built(count)
        puts "#{COLORS[:green]}#{EMOJIS[:done]} Built #{count} regions successfully#{COLORS[:reset]}"
      end

      def log_case1_start
        puts "\n#{COLORS[:yellow]}#{EMOJIS[:calculate]} Calculating garden prices (Case 1)...#{COLORS[:reset]}"
      end

      def log_case1_result(total)
        puts "#{COLORS[:green]}#{EMOJIS[:total]} Case 1 total price: #{total}#{COLORS[:reset]}"
      end
    end
  end
end
