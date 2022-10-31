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
FactoryBot.define do
  factory :donation do
    amount { 1000 }
    currency { 'UY' }
    message { 'Thanks for the great work!' }

    association :beneficiary, factory: :user
  end

  factory :user_donation, parent: :donation, class: UserDonation do
    association :donor, factory: :user
  end

  factory :anonymous_donation, parent: :donation, class: AnonymousDonation do
    message { 'I do not have an user' }
  end
end
