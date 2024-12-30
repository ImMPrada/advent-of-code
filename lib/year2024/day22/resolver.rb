module Year2024
  module Day22
    class Resolver
      FILE_PATH = 'lib/year2024/day22/input.txt'.freeze
      MODULO = 16_777_216
      TARGET_ITERATION = 2000

      def initialize(path = nil)
        file_path = path || FILE_PATH
        @initial_secrets = File.readlines(file_path).map(&:to_i)
      end

      def run_case1
        @initial_secrets.sum do |initial|
          secret = initial
          TARGET_ITERATION.times do
            secret = evolve_secret(secret)
          end
          secret
        end
      end

      private

      def evolve_secret(secret)
        result = mix_and_prune(secret, secret * 64)
        result = mix_and_prune(result, result / 32)

        mix_and_prune(result, result * 2048)
      end

      def mix_and_prune(secret, value)
        mixed = secret ^ value
        mixed % MODULO
      end
    end
  end
end
