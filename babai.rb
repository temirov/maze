require_relative 'models/actor'
require_relative 'models/maze'

maze = Maze.new 9, 9
babai = Actor.new maze

# x = STDIN.gets.chomp
# y = STDIN.gets.chomp

babai.pass steps: 70
puts babai.path

# puts babai.step_number_of x.to_i, y.to_i
