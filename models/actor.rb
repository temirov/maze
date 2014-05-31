class Actor 
  attr_accessor :path

  def initialize maze, gait: Gait.new
    raise ArgumentError unless 
      maze.respond_to? :accessible? and 
      maze.respond_to? :teleport_from and 
      maze.respond_to? :enter and 
      maze.respond_to? :exit and 
      gait.respond_to? :step and
      gait.respond_to? :restart and
    
    @maze = maze
    @gait = gait
    @location = @maze.enter
    raise ArgumentError unless @location.respond_to? :move

    @path = [@location]
  end

  def pass stop_at: @maze.exit, steps: @maze.cells
    raise ArgumentError unless @maze.accessible? stop_at and steps < @maze.cells

    walk until path.last == stop_at or path.count == steps
  end

  private
    def visited? cell
      path.include? cell
    end
    def jump
      self.location = @maze.teleport_from path.last
      @gait.restart
    end
    def location
      @location.dup
    end
    def location= cell
      @location = cell
      @path << location
    end
    def walk
      next_step = location.move @gait.step
      if visited? next_step or not @maze.accessible? next_step
        jump
      else
        self.location = next_step
      end
    end

  class Gait
    attr_accessor :steps

    def initialize steps: [:right, :down, :left], first_step: 0
      @steps = steps
      @index = first_step
    end

    def step
      restart if @index == steps.count
      step = steps[@index]
      @index += 1
      step
    end

    def restart
      @index = 0 
    end
  end
end
