# == Schema Information
#
# Table name: objectives
#
#  id             :bigint           not null, primary key
#  name           :string           not null
#  description    :string           not null
#  state          :string           default("active"), not null
#  start_date     :date             not null
#  end_date       :date
#  target_amount  :integer          not null
#  current_amount :integer          default(0), not null
#  user_id        :bigint           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_objectives_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe Objective, type: :model do
  describe 'validations' do
    subject { build :objective }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to validate_presence_of(:target_amount) }
    it { is_expected.to validate_presence_of(:current_amount) }
    it {
      is_expected.to validate_inclusion_of(:state).in_array(%w[active goal_reached goal_not_reached
                                                               canceled])
    }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'aasm' do
    let(:user) { create :user }
    subject { build :objective, user:, current_amount: 100, target_amount: 100 }

    it { is_expected.to transition_from(:active).to(:goal_reached).on_event(:reached) }
    it { is_expected.to transition_from(:active).to(:goal_not_reached).on_event(:not_reached) }
    it { is_expected.to transition_from(:active).to(:canceled).on_event(:cancel) }

    context 'when state is goal_reached' do
      subject { build :objective, state: 'goal_reached', current_amount: 100, target_amount: 100 }

      it { is_expected.not_to transition_from(:goal_reached).to(:active).on_event(:reached) }
      it {
        is_expected.not_to transition_from(:goal_reached)
          .to(:goal_not_reached).on_event(:not_reached)
      }
      it { is_expected.not_to transition_from(:goal_reached).to(:canceled).on_event(:cancel) }
    end

    context 'when state is goal_not_reached' do
      subject { build :objective, state: 'goal_not_reached' }

      it { is_expected.not_to transition_from(:goal_not_reached).to(:active).on_event(:reached) }
      it {
        is_expected.not_to transition_from(:goal_not_reached)
          .to(:goal_reached).on_event(:not_reached)
      }
      it { is_expected.not_to transition_from(:goal_not_reached).to(:canceled).on_event(:cancel) }
    end

    context 'when state is canceled' do
      subject { build :objective, state: 'canceled' }

      it { is_expected.not_to transition_from(:canceled).to(:active).on_event(:reached) }
      it { is_expected.not_to transition_from(:canceled).to(:goal_reached).on_event(:not_reached) }
      it { is_expected.not_to transition_from(:canceled).to(:goal_not_reached).on_event(:cancel) }
    end
  end

  describe 'methods' do
    describe '#validate_start_date' do
      context 'when start_date is in the past' do
        subject { build :objective, start_date: Date.yesterday }

        it 'should add an error' do
          subject.save!
          expect(subject.errors[:start_date]).to include("can't be in the past")
        end

        it 'sends a message to Sentry' do
          expect(Sentry).to receive(:capture_message)
            .with("Objective start date can't be in the past")
          subject.save!
        end
      end

      context 'when start_date is in the future' do
        subject { build :objective, start_date: Date.tomorrow }

        it 'does not add an error to start_date' do
          subject.save!
          expect(subject.errors[:start_date]).to be_empty
        end

        it 'does not send a message to Sentry' do
          expect(Sentry).not_to receive(:capture_message)
          subject.save!
        end
      end
    end
  end

  describe 'active job' do
    context 'when objective is reached' do
      let!(:objective) { create :objective, target_amount: 100, current_amount: 100 }

      it 'sends a notification' do
        objective.reached!

        expect(enqueued_jobs.size).to eq(1)
        expect(enqueued_jobs.last[:job]).to eq(CreateNotificationJob)
      end
    end
  end
end
