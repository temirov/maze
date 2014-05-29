require_relative 'models/actor'

# actor = Actor.new(step: Step.new(steps: [:right, :down]))
babai = Actor.new
babai.pass

x = STDIN.gets.chomp
y = STDIN.gets.chomp
babai.step_number_of x.to_i, y.to_i
