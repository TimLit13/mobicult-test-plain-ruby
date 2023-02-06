RSpec.describe Team do
  let(:first_player) { Player.new('Cri', 'Ro') }
  let(:second_player) { Player.new('Leo', 'Me') }
  let(:team) { described_class.new('New team') }
  
  describe 'new instance' do
    it 'Title should be a string' do
      expect(team.name).to be_an_instance_of(String)
    end

    it 'increase amount of instances' do
      expect { team }.to change { described_class.teams.count }.by(1)
    end
  end

  describe '#tansfer_player_in' do
    before { team.transfer_player_in(first_player) }

    it 'tranfer player to team' do
      expect { team.transfer_player_in(second_player) }.to change { team.team_players.count }.by(1)
    end

    it 'transfer right player to team' do
      team.transfer_player_in(second_player)
      
      expect(team.team_players.last.first_name).to eq(second_player.first_name)
    end
  end

  describe '#tansfer_player_out' do
    before { team.transfer_player_in(first_player) }

    it 'tranfer player out of team' do
      expect { team.transfer_player_out(first_player) }.to change { team.team_players.count }.by(-1)
    end
  end
end
