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
class Objective < ApplicationRecord
  include AASM

  belongs_to :user

  validates :name, presence: true
  validates :description, presence: true
  validates :state, presence: true
  validates :target_amount, presence: true
  validates :current_amount, presence: true
  validates :state, inclusion: { in: %w[active goal_reached goal_not_reached canceled] }

  aasm column: :state do
    state :active, initial: true
    state :goal_reached
    state :goal_not_reached
    state :canceled

    event :reached do
      transitions from: :active, to: :goal_reached, guard: :amount_reached?,
                  after: :goal_reached_notification
    end
    event :not_reached do
      transitions from: :active, to: :goal_not_reached
    end

    event :cancel do
      transitions from: :active, to: :canceled
    end
  end

  before_create :start_date_valid?

  private

  def aasm_event_failed(event_name, old_state_name)
    Sentry.capture_message("Objective failed to transit from #{old_state_name} to #{event_name}")
  end

  def start_date_valid?
    return unless start_date < Time.zone.today

    errors.add(:start_date, "can't be in the past")
    Sentry.capture_message("Objective start date can't be in the past")
  end

  def amount_reached?
    current_amount >= target_amount
  end

  def goal_reached_notification
    CreateNotificationJob.perform_later(user, 'goal_reached',
                                        "¡Has alcanzado tu meta de #{target_amount} matecitos!")
  end
end
