require 'set'
require_relative 'cell'

class Maze
  attr_accessor :visited, :height, :width, :x_start, :y_start

  def initialize height, width, x_start = 1, y_start = 1
    @height, @width = height, width
    @x_start, @y_start = x_start, y_start
    @visited = []
  end

  def trail
    (y_start..height).map do |w|
      (x_start..width).map do |h|
        Cell.new(w,h)
      end
    end.flatten
  end

  def teleport
    remaining = trail - visited
    remaining.first
  end

  def go_to cell
    return false if visited?(cell) or wall?(cell)
    self.visited << cell.dup
    true
  end

  def visited? cell
    visited.include? cell
  end

  def end?
    visited.to_set == trail.to_set
  end

  def wall? cell
    raise ArgumentError unless cell.respond_to?(:x) && cell.respond_to?(:y)
    cell.x > self.height or 
    cell.y > self.width or 
    cell.y < 1 or 
    cell.x < 1
  end
end
