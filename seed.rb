module Seed
  def seed
    seed_players

    seed_teams

    seed_matches

    seed_performance_goals

    seed_performances
  end

  private

  def seed_players
    6.times { |ind| Player.new("#{ind + 1} player name", "#{ind + 1} player last name") }
  end

  def seed_teams
    2.times { |ind| Team.new("#{ind + 1} team") }
    3.times { |ind| Team.teams.first.transfer_player_in(Player.players[ind]) }
    3.times { |ind| Team.teams.last.transfer_player_in(Player.players[ind + 3]) }
  end

  def seed_matches
    3.times { Match.new(Team.teams.first, Team.teams.last) }
  end

  def seed_performance_goals
    PerformanceGoal.new('Scores', 1)
    PerformanceGoal.new('Assists', 1)
  end

  def seed_performances
    Match.matches.each do |match_played|
      match_played.teams.last.team_players.each do |player|
        2.times { PlayerPerformance.new(player, match_played) }
      end
    end
    PlayerPerformance.player_performances[0..PlayerPerformance.player_performances.count / 2].each do |player_performance|
      player_performance.performance_goal_reached(PerformanceGoal.performance_goals.first.title)
      player_performance.performance_goal_reached(PerformanceGoal.performance_goals.last.title)
    end
  end
end
