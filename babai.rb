require_relative 'models/actor'
require_relative 'models/maze'

maze = Maze.new 9, 9
babai = Actor.new maze

# x = STDIN.gets.chomp
# y = STDIN.gets.chomp

# babai.pass steps: 70
# puts babai.path
babai.pass stop: Maze::Cell.new(4,5)
puts babai.path
