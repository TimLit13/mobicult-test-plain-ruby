class PlayerPerformance
  class << self
    attr_accessor :player_performances
  end

  attr_reader :player, :match_played, :reached_stats

  @player_performances = []

  def initialize(player, match_played)
    @player = player
    @match_played = match_played
    @reached_stats = {}

    PerformanceGoal.performance_goals.each { |performance_goal| @reached_stats[performance_goal.title.to_sym] = false }

    PlayerPerformance.player_performances.push(self)
  end

  class << self
    def player_reached_performance?(player, stat, matches_count)
      PlayerPerformance.player_performances.select { |player_performance| player_performance.player == player }
                       .last(matches_count)
                       .inject(false) { |result, player_performance| result || player_performance.reached_stats[stat.to_sym] }
    end

    def top_players_by_performance(stat, players_count)
      find_top_players(stat, players_count, PlayerPerformance.player_performances)
    end

    def top_team_players_by_performance(stat, players_count, team)
      collection = PlayerPerformance.player_performances.select { |player_performance| player_performance.player.team == team }
      find_top_players(stat, players_count, collection)
    end

    def find_top_players(stat, players_count, collection)
      collection.select { |player_performance| player_performance.reached_stats[stat.to_sym] == true }
                .group_by(&:player)
                .sort_by { |_player, reached_player_performances| reached_player_performances.count }
                .to_h
                .keys
                .last(players_count)
    end
  end

  def performance_goal_reached(title)
    @reached_stats[title.to_sym] = true if @reached_stats.key?(title.to_sym)
  end
end
