# == Schema Information
#
# Table name: trophies
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  description :string           not null
#  category    :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_trophies_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :trophy do
    name { Faker::Lorem.word }
    category { 'silver' }
    description { Faker::Lorem.sentence }
  end
end
