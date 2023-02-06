RSpec.describe Player do
  let(:new_player) { described_class.new('Cri', 'Ro') }
  
  describe 'new instance' do
    it 'should create new instance' do
      expect(new_player.first_name).to eq(described_class.players.first.first_name)
    end

    it 'Name should be a string' do
      expect(new_player.first_name).to be_an_instance_of(String)
    end

    it 'should increase amount of instances' do
      expect { new_player }.to change { described_class.players.count }.by(1)
    end
  end
end
