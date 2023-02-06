RSpec.describe PerformanceGoal do
  let(:new_goal) { described_class.new('more than 10 kms', 10) }
  
  describe 'new instance' do
    it 'increase amount of instances' do
      expect { new_goal }.to change { described_class.performance_goals.count }.by(1)
    end

    it 'make new goal with right titile' do
       expect(new_goal.title).to eq(PerformanceGoal.performance_goals.first.title)
    end
  end
end
