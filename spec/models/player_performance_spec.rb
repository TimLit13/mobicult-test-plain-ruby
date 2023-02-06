RSpec.describe PlayerPerformance do
  let!(:first_player) { Player.new('Cri', 'Ro') }
  let!(:second_player) { Player.new('Leo', 'Me') }
  let(:first_team) { Team.new('First team') }
  let(:second_team) { Team.new('Second team') }
  let(:new_match) { Match.new(first_team, second_team) }
  let(:new_goal) { PerformanceGoal.new('more than 10 kms', 10) }
  let(:new_performance) { described_class.new(first_player, new_match) }
  
  describe 'new instance' do
    it 'increase amount of instances' do
      expect { new_performance }.to change { described_class.player_performances.count }.by(1)
    end

    it 'make reached_stats as hash' do
      expect(new_performance.reached_stats).to be_an_instance_of(Hash)
    end

    it 'set false for reached performance goal by default' do
      expect(new_performance.reached_stats[new_goal.title]).to be_falsey
    end
  end

  describe '#performance_goal_reached' do
    before { new_performance.performance_goal_reached(new_goal.title) }

    it 'set true for reached performance goal' do
      expect(new_performance.reached_stats[new_goal.title.to_sym]).to be_truthy
    end

    it 'does not change reached goals' do
      expect { new_performance.performance_goal_reached('other_goal') }.not_to change { new_performance.reached_stats.count }
    end

    it 'does not have other reached goal' do
      new_performance.performance_goal_reached('other_goal')

      expect(new_performance.reached_stats).not_to include(:other_goal)
    end
  end

  describe '.top_players_by_performance' do
    before do
      Player.players = []
      Match.matches = []
      Team.teams = []
      PerformanceGoal.performance_goals = []
      PlayerPerformance.player_performances = []

      @first_player = Player.new('Cri', 'Ro')
      @second_player = Player.new('Leo', 'Me')
      @third_player = Player.new('Pao', 'Dib')
      @fourth_player = Player.new('Raf', 'Le')
      @fifth_player = Player.new('Lu', 'Mod')
      @sixth_player =  Player.new('Ro', 'Lew')

      @first_team = Team.new('First team')
      @second_team = Team.new('Second team')

      3.times { |ind| @first_team.transfer_player_in(Player.players[ind]) }
      3.times { |ind| @second_team.transfer_player_in(Player.players[ind + 3]) }

      @new_goal = PerformanceGoal.new('more than 10 kms', 10)

      5.times do
        5.times do |ind|
          described_class.new(Player.players[ind], new_match).performance_goal_reached(@new_goal.title)
        end
      end
    end

    it 'returns top 5 players by performance' do
      expect(described_class.top_players_by_performance(@new_goal.title, 5).count).to eq(5)
      expect(described_class.top_players_by_performance(@new_goal.title, 5)).to include(@second_player)
    end

    it 'returns not more than passed players count by performance' do
      expect(described_class.top_players_by_performance(@new_goal.title, 3).count).to eq(3)
    end

    it 'does not include player without reached performance' do
      expect(described_class.top_players_by_performance(@new_goal.title, 3)).not_to include(@sixth_player)
    end
  end

  describe '.top_team_players_by_performance' do
    before do
      Player.players = []
      Match.matches = []
      Team.teams = []
      PerformanceGoal.performance_goals = []
      PlayerPerformance.player_performances = []

      @first_player = Player.new('Cri', 'Ro')
      @second_player = Player.new('Leo', 'Me')
      @third_player = Player.new('Pao', 'Dib')
      @fourth_player = Player.new('Raf', 'Le')
      @fifth_player = Player.new('Lu', 'Mod')
      @sixth_player =  Player.new('Ro', 'Lew')

      @first_team = Team.new('First team')
      @second_team = Team.new('Second team')

      3.times { |ind| @first_team.transfer_player_in(Player.players[ind]) }
      3.times { |ind| @second_team.transfer_player_in(Player.players[ind + 3]) }

      @new_goal = PerformanceGoal.new('more than 10 kms', 10)

      5.times do
        5.times do |ind|
          described_class.new(Player.players[ind], new_match).performance_goal_reached(@new_goal.title)
        end
      end
    end

    it 'returns top 3 team players by performance' do
      expect(described_class.top_team_players_by_performance(@new_goal.title, 5, @first_team).count).to eq(@first_team.team_players.count)
      expect(described_class.top_team_players_by_performance(@new_goal.title, 5, @first_team)).to include(@second_player)
    end

    it 'returns not more than passed players count by performance' do
      expect(described_class.top_players_by_performance(@new_goal.title, 1).count).to eq(1)
    end

    it 'does not include player without reached performance' do
      expect(described_class.top_team_players_by_performance(@new_goal.title, 3, @second_team)).not_to include(@sixth_player)
    end

    it 'does not include player from other team' do
      expect(described_class.top_team_players_by_performance(@new_goal.title, 3, @second_team)).not_to include(@first_player)
    end
  end
end
