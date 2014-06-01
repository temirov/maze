class Maze
  def initialize height, width, x_start = 1, y_start = 1
    @height, @width, @x_start, @y_start = height, width, x_start, y_start
  end

  def cells
    trail.count
  end

  def enter
    trail.first
  end

  def exit
    trail.last
  end 

  def accessible_at? cell
    not wall?(cell)
  end

  def teleport_from cell
    current_index = trail.index(cell) 
    next_index = current_index + 1 
    trail[next_index]
  end

  private
    def trail
      @trail ||= (@y_start..@height).map do |w|
        (@x_start..@width).map do |h|
          Cell.new(w,h)
        end
      end.flatten
    end

    def wall? cell
      raise ArgumentError unless 
        cell.respond_to? :x and 
        cell.respond_to? :y

      cell.x > @height or 
      cell.y > @width or 
      cell.y < @y_start or 
      cell.x < @x_start
    end

  class Cell < Struct.new :x,:y
    def move direction
      raise ArgumentError unless [:up, :down, :left, :right].include? direction
      self.send direction
      self
    end

    def to_s
      "x=#{x}, y=#{y}"
    end
    
    private 
      def up
        self.y -= 1
      end
      def down
        self.y += 1
      end
      def left
        self.x -= 1
      end
      def right
        self.x += 1
      end
  end
end
