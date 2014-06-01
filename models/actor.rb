require 'forwardable'

class Actor 
  attr_accessor :path

  def initialize maze, gait: Gait.new
    raise ArgumentError unless 
      maze.respond_to? :accessible_at? and 
      maze.respond_to? :teleport_from and 
      maze.respond_to? :enter and 
      maze.respond_to? :exit and 
      gait.respond_to? :step and
      gait.respond_to? :restart and
    
    @maze = maze
    @gait = gait

    @location = @maze.enter
    raise ArgumentError unless @location.respond_to? :move

    @path = Path.new([location])
  end

  def pass stop: @maze.exit, steps: @maze.cells
    raise ArgumentError unless @maze.accessible_at? stop and steps <= @maze.cells

    walk until path.last == stop or path.count == steps
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
      if visited? next_step or not @maze.accessible_at? next_step
        jump
      else
        self.location = next_step
      end
    end

  class Path 
    extend Forwardable
    def_delegators :@list, :<<, :count, :include?, :last, :each_with_index, :map

    def initialize(list = [])
      @list = list
    end

    def to_ary
      self.map.each_with_index{ |e, i| "#{e}, step: #{i}" }
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
