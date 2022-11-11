# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  body       :text             not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  url        :string
#  category   :integer          default("standard"), not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence(word_count: 3) }
    body { Faker::Lorem.paragraph }
    category { 0 }
    image do
      Rack::Test::UploadedFile.new(Rails.root.join('spec', 'assets', 'image.jpeg'),
                                   'image/jpeg')
    end

    association :user, factory: :user
  end
end
