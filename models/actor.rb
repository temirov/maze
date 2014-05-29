require_relative 'cell'
require_relative 'maze'
require_relative 'step'

class Actor 
  attr_accessor :location, :maze, :step, :path

  def initialize location: Cell.new(1,1), maze: Maze.new(9,9), step: Step.new
    raise ArgumentError unless 
      location.respond_to? :move and 
      maze.respond_to? :go_to and 
      maze.respond_to? :teleport and 
      step.respond_to? :next and
      step.respond_to? :restart and

    @location = location
    @maze = maze
    @step = step
  end

  def walk
    if maze.go_to location
      location.move step.next
    else
      self.location = maze.teleport
      step.restart
    end
  end

  def pass
    walk until maze.end?
    self.path = maze.visited.dup
  end

  def visited? x, y
    path.include? Cell.new(x,y)
  end

  def step_coordinates_of step_number
    puts path[step_number-1]
  end
  def step_number_of x, y
    puts path.index(Cell.new(x,y))
  end
end
