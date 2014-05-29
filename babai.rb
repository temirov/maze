# require 'pry'
# require 'pry-debugger'
# require 'pry-stack_explorer'

require_relative 'models/actor'

# actor = Actor.new(step: Step.new(steps: [:right, :down]))
babai = Actor.new
babai.pass
puts babai.path

# i = 1
# lines = []

# ARGF.each do |line|
#   lines << line
#   if i == 2
#     actor.step_number_of line[0], line[1]
#     i = 0
#     lines = []
#   end
#   i += 1
# end
