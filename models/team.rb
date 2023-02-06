class Team
  class << self
    attr_accessor :teams
  end

  attr_reader :team_players, :name

  @teams = []

  def initialize(team_name)
    @team_players = []
    @name = team_name

    Team.teams.push(self)
  end

  def transfer_player_in(player)
    @team_players.push(player)
    player.team = self
  end

  def transfer_player_out(player)
    @team_players.delete(player)
    player.team = nil
  end
end
