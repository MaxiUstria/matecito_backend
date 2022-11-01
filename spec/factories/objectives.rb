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
FactoryBot.define do
  factory :objective do
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    start_date { Time.zone.today }
    end_date { Time.zone.today + 1.month }
    target_amount { 1000 }
    current_amount { 0 }

    association :user, factory: :user
  end
end
