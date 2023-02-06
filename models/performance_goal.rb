class PerformanceGoal
  class << self
    attr_accessor :performance_goals
  end

  attr_reader :title, :value

  @performance_goals = []

  def initialize(title, value)
    @title = title.to_s
    @value = value

    PerformanceGoal.performance_goals.push(self)
  end
end
