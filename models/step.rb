class Step
  attr_accessor :index, :steps

  def initialize steps: [:right, :down, :left], first_step: 0
    @steps = steps
    @index = first_step
  end

  def next
    restart if index == steps.count
    step = steps[index]
    self.index += 1
    step
  end

  def restart
    self.index = 0 
  end
end
