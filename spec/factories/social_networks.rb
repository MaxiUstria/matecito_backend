# == Schema Information
#
# Table name: social_networks
#
#  id         :bigint           not null, primary key
#  url        :string           not null
#  app        :integer          not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_social_networks_on_user_id          (user_id)
#  index_social_networks_on_user_id_and_app  (user_id,app) UNIQUE
#
FactoryBot.define do
  factory :social_network do
    url { 'https://www.instagram.com/matecito_app' }
    app { 'instagram' }

    association :user, factory: :user
  end
end
