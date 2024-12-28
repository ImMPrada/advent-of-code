module Year2024
  module Day22
    class Resolver
      FILE_PATH = 'lib/year2024/day22/input.txt'.freeze
      MODULO = 16777216 # For pruning
      TARGET_ITERATION = 2000
      SEQUENCE_LENGTH = 4

      def initialize(path = nil)
        file_path = path || FILE_PATH
        @initial_secrets = File.readlines(file_path).map(&:to_i)
      end

      def run_case2
        # Generate all price sequences for each buyer
        price_sequences = @initial_secrets.map do |initial|
          generate_price_sequence(initial)
        end

        # Find best sequence of changes
        best_sequence = nil
        max_bananas = 0

        # Try all possible sequences of 4 changes (-9 to 9 for each position)
        (-9..9).each do |a|
          (-9..9).each do |b|
            (-9..9).each do |c|
              (-9..9).each do |d|
                sequence = [a, b, c, d]
                total = evaluate_sequence(sequence, price_sequences)
                
                if total > max_bananas
                  max_bananas = total
                  best_sequence = sequence
                  puts "New best: #{sequence.inspect} = #{total} bananas"
                end
              end
            end
          end
        end

        puts "\nBest sequence: #{best_sequence.inspect}"
        puts "Total bananas: #{max_bananas}"
        max_bananas
      end

      private

      def generate_price_sequence(initial)
        prices = [initial % 10] # Start with ones digit of initial
        current = initial

        TARGET_ITERATION.times do
          current = evolve_secret(current)
          prices << current % 10 # Only keep ones digit
        end

        # Convert to changes
        changes = []
        (1...prices.size).each do |i|
          changes << prices[i] - prices[i-1]
        end

        [prices, changes]
      end

      def evaluate_sequence(target_sequence, price_sequences)
        price_sequences.sum do |prices, changes|
          find_first_price_for_sequence(prices, changes, target_sequence)
        end
      end

      def find_first_price_for_sequence(prices, changes, target_sequence)
        # Look for target sequence in changes
        (0..changes.size - SEQUENCE_LENGTH).each do |i|
          current_sequence = changes[i, SEQUENCE_LENGTH]
          if current_sequence == target_sequence
            return prices[i + SEQUENCE_LENGTH] # Return price at point of sale
          end
        end
        0 # No match found
      end

      def evolve_secret(secret)
        # Step 1: Multiply by 64 and mix
        result = mix_and_prune(secret, secret * 64)
        
        # Step 2: Divide by 32 and mix
        result = mix_and_prune(result, result / 32)
        
        # Step 3: Multiply by 2048 and mix
        mix_and_prune(result, result * 2048)
      end

      def mix_and_prune(secret, value)
        # Mix (XOR)
        mixed = secret ^ value
        
        # Prune (modulo)
        mixed % MODULO
      end
    end
  end
end
