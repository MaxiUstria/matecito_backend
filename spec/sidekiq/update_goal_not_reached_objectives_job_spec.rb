require 'rails_helper'
RSpec.describe UpdateGoalNotReachedObjectivesJob, type: :job do
  include ActiveJob::TestHelper
  let!(:user) { create :user }
  let!(:objective) { create :objective, user:, end_date: Time.zone.yesterday }

  subject { described_class.perform_now }

  it 'update active objective to goal_not_reached' do
    subject

    expect(objective.reload).to be_goal_not_reached
  end

  context 'when end date is nil' do
    let!(:objective) { create :objective, user:, end_date: nil }

    it 'does not update the objective' do
      subject

      expect(objective.reload).to be_active
    end
  end

  context 'when end date is in the future' do
    let!(:objective) { create :objective, user:, end_date: Time.zone.tomorrow }

    it 'does not update the objective' do
      subject

      expect(objective.reload).to be_active
    end
  end
end
