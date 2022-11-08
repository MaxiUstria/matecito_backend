# == Schema Information
#
# Table name: donations
#
#  id             :bigint           not null, primary key
#  amount         :integer          not null
#  currency       :string           default("UY"), not null
#  message        :string
#  beneficiary_id :bigint           not null
#  donor_id       :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_donations_on_beneficiary_id  (beneficiary_id)
#  index_donations_on_donor_id        (donor_id)
#
class Donation < ApplicationRecord
  belongs_to :beneficiary, class_name: 'User'
  belongs_to :donor, class_name: 'User', optional: true

  validates :amount, presence: true
  validates :currency, presence: true
  validates :message, length: { maximum: 500 }

  after_create :create_notification
  after_create :increase_objective_counter

  private

  def create_notification
    CreateNotificationJob.perform_later(beneficiary, 'new_donation',
                                        "#{donor.present? ? donor.full_name : 'alguien'}
                                         ha donado #{amount} matecitos!")
  end

  def increase_objective_counter
    IncreaseObjectiveCounterJob.perform_later(beneficiary, self)
  end
end
