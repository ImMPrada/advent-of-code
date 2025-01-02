module Year2024
  module Day19
    class Resolver
      FILE_PATH = 'lib/year2024/day19/input.txt'.freeze

      attr_reader :patterns, :designs

      def initialize(path = nil)
        file_path = path || FILE_PATH
        lines = File.readlines(file_path).map(&:chomp)

        @patterns = parse_patterns(lines[0])
        @designs = lines[2..].reject(&:empty?)
      end

      def run_case1
        count = 0

        @designs.each do |design|
          reduced_parts = split_design(design)
          count += 1 if reduced_parts.empty?
        end

        count
      end

      private

      def parse_patterns(line)
        line.split(', ').map(&:strip).sort_by { |pattern| -pattern.length }
      end

      def split_design(design)
        reduced_parts = [design]
        count = 1
        patterns.each do |pattern|
          puts "#{count * 100.0 / patterns.size}%"
          puts "pattern: #{pattern}"
          puts "reduced_parts: #{reduced_parts}"
          puts '---'
          new_reduced_parts = []
          reduced_parts.each do |part|
            part.split(pattern).each do |obtained_part|
              new_reduced_parts << obtained_part if obtained_part.length.positive?
            end
          end

          reduced_parts = new_reduced_parts
          count += 1
        end

        reduced_parts
      end
    end
  end
end
