require_relative 'constants'

# Cache for memoization
@ways_cache = {}
@cost_cache = {}

# Reuse these functions from part_one.rb
def build_direction(next_loc, current_location)
  direction_i = next_loc[0] - current_location[0]
  direction_j = next_loc[1] - current_location[1]

  [direction_i, direction_j]
end

def build_moves(direction_i, direction_j)
  moves = ''

  moves += 'v' * direction_i if direction_i.positive?
  moves += '^' * -direction_i if direction_i.negative?

  moves += '>' * direction_j if direction_j.positive?
  moves += '<' * -direction_j if direction_j.negative?

  moves
end

def build_directional_combos(raw_combos, starting_location, keypad_map)
  combos = []

  raw_combos.each do |combo|
    starting_i, starting_j = starting_location
    good = true

    combo[0...-1].each_char do |direction|
      direction_i, direction_j = MOVES[direction]
      starting_i += direction_i
      starting_j += direction_j
      unless keypad_map.values.include?([starting_i, starting_j])
        good = false
        break
      end
    end

    combos << combo if good
  end

  combos
end

def generate_ways(initial_index, next_index, keypad)
  cache_key = [initial_index, next_index, keypad]
  return @ways_cache[cache_key] if @ways_cache.key?(cache_key)

  keypad_map = keypad ? DIRECTIONAL_KEYPAD : NUMERIC_KEYPAD
  cur_loc = keypad_map[initial_index]
  next_loc = keypad_map[next_index]

  direction_i, direction_j = build_direction(next_loc, cur_loc)
  moves = build_moves(direction_i, direction_j)

  raw_combos = moves.chars.permutation.map(&:join).uniq.map { |x| "#{x}A" }
  combos = build_directional_combos(raw_combos, cur_loc, keypad_map)

  @ways_cache[cache_key] = combos
  combos
end

def get_cost(first_point_of_sequence, second_point_of_sequence, keypad, depth = 0)
  cache_key = [first_point_of_sequence, second_point_of_sequence, keypad, depth]
  return @cost_cache[cache_key] if @cost_cache.key?(cache_key)

  if depth.zero?
    raise 'Invalid keypad' unless keypad

    result = generate_ways(first_point_of_sequence, second_point_of_sequence, true).map(&:length).min
    @cost_cache[cache_key] = result
    return result
  end

  compute_cost(first_point_of_sequence, second_point_of_sequence, keypad, cache_key, depth)
end

def compute_cost(first_point_of_sequence, second_point_of_sequence, keypad, cache_key, depth)
  ways = generate_ways(first_point_of_sequence, second_point_of_sequence, keypad)
  best_cost = Float::INFINITY

  ways.each do |way|
    way = "A#{way}"
    cost = 0
    (0...way.length - 1).each do |i|
      cost += get_cost(way[i], way[i + 1], true, depth - 1)
    end
    best_cost = [best_cost, cost].min
  end

  @cost_cache[cache_key] = best_cost

  best_cost
end

def get_code_cost(code, depth)
  code = "A#{code}"
  cost = 0
  (0...code.length - 1).each do |i|
    cost += get_cost(code[i], code[i + 1], false, depth)
  end
  cost
end

puts "\e[33mSolving part 2...\e[0m"
ans = 0

File.readlines('lib/year2024/day21/input.txt').map(&:chomp).each do |line|
  cost = get_code_cost(line, 25)
  code = line[0...-1].to_i
  puts "\e[33m  Cost for #{line}: #{cost} * #{code}\e[0m"
  ans += cost * code
end

puts "\e[32mAnswer: #{ans}\e[0m"
