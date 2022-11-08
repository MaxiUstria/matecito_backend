require 'rails_helper'
RSpec.describe IncreaseObjectiveCounterJob, type: :job do
  include ActiveJob::TestHelper
  let!(:user) { create :user }
  let!(:donation) { create :donation, beneficiary: user }
  let!(:objective) { create :objective, user: }

  subject { described_class.perform_now(user, donation) }

  it 'increases the objective counter' do
    subject

    expect(objective.reload.current_amount).to eq(donation.amount)
  end

  context 'when the objective is completed' do
    let(:objective) { create :objective, user:, state: 'goal_reached', current_amount: 1000 }

    it 'completes the objective' do
      subject

      expect(objective.reload.current_amount).to eq(1000 + donation.amount)
    end
  end

  context 'when the objective is not active' do
    let(:objective) do
      create :objective, user:, end_date: Time.zone.yesterday, current_amount: 1000
    end

    it 'does not increase the objective counter' do
      subject

      expect(objective.reload.current_amount).to eq(1000)
    end
  end

  context 'when there are two objectives and one end date is nil' do
    let(:objective) { create :objective, user:, end_date: nil, current_amount: 1000 }
    let!(:objective2) do
      create :objective, user:, end_date: Time.zone.tomorrow, current_amount: 100
    end

    it 'increases the objective counter' do
      subject

      expect(objective.reload.current_amount).to eq(1000 + donation.amount)
      expect(objective2.reload.current_amount).to eq(100 + donation.amount)
    end
  end

  context 'when the goal is reached' do
    let(:objective) { create :objective, user:, target_amount: 1000, current_amount: 999 }

    it 'completes the objective' do
      subject

      expect(objective.reload.current_amount).to eq(999 + donation.amount)
      expect(objective.reload).to be_goal_reached
    end
  end
end
