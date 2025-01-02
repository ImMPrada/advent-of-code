require_relative 'constants'
require 'byebug'

def paths(code, keypad)
  parts = []
  current_location = keypad['A']

  code.each_char do |c|
    next_loc = keypad[c]
    direction_i, direction_j = build_direction(next_loc, current_location)

    moves = build_moves(direction_i, direction_j)

    raw_combos = moves.chars.permutation.map(&:join).uniq.map { |x| "#{x}A" }
    combos = build_directional_combos(raw_combos, current_location, keypad)

    parts << combos
    current_location = next_loc
  end

  parts[0].product(*parts[1..]).map(&:join)
end

def build_moves(direction_i, direction_j)
  moves = ''

  moves += 'v' * direction_i if direction_i.positive?
  moves += '^' * -direction_i if direction_i.negative?

  moves += '>' * direction_j if direction_j.positive?
  moves += '<' * -direction_j if direction_j.negative?

  moves
end

def build_directional_combos(raw_combos, starting_location, keypad)
  combos = []

  raw_combos.each do |combo|
    starting_i, starting_j = starting_location
    good = true

    combo[0...-1].each_char do |direction|
      direction_i, direction_j = MOVES[direction]
      starting_i += direction_i
      starting_j += direction_j
      unless keypad.values.include?([starting_i, starting_j])
        good = false
        break
      end
    end

    combos << combo if good
  end

  combos
end

def build_direction(next_loc, current_location)
  direction_i = next_loc[0] - current_location[0]
  direction_j = next_loc[1] - current_location[1]

  [direction_i, direction_j]
end

def robots_shortest_path(code)
  robot1_paths = paths(code, NUMERIC_KEYPAD)

  robot2_paths = []
  robot1_paths.each do |path|
    robot2_paths.concat(paths(path, DIRECTIONAL_KEYPAD))
  end

  robot3_paths = []
  robot2_paths.each do |path|
    robot3_paths.concat(paths(path, DIRECTIONAL_KEYPAD))
  end

  robot3_paths.min_by(&:length)
end

ans = 0

puts "\e[33mSolving...\e[0m"

File.readlines('lib/year2024/day21/input.txt').map(&:chomp).each do |line|
  path = robots_shortest_path(line)
  length = path.length
  code = line[0...-1].to_i
  puts "\e[33m  #{path} -- #{length} #{code}\e[0m"
  ans += length * code
end

puts "\e[32m#{ans}\e[0m"
