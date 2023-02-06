class Match
  class << self
    attr_accessor :matches
  end

  attr_reader :teams

  @matches = []

  def initialize(team1, team2)
    @teams = [team1, team2]

    Match.matches.push(self)
  end
end
