RSpec.describe Match do
  let(:first_team) { Team.new('first team') }
  let(:second_team) { Team.new('second team') }
  let(:new_match) { described_class.new(first_team, second_team) }
  
  describe 'new instance' do
    it 'increase amount of instances' do
      expect { new_match }.to change { described_class.matches.count }.by(1)
    end

    it 'add teams to match' do
      expect(new_match.teams).to eq([first_team, second_team])
    end
  end
end
