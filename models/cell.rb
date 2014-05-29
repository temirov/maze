class Cell < Struct.new :x,:y
  def move direction
    raise ArgumentError unless [:up, :down, :left, :right].include? direction
    self.send direction
    self
  end

  def to_s
    "x=#{x}, y=#{y};\n"
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
