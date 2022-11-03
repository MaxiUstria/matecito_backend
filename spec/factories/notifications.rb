# == Schema Information
#
# Table name: notifications
#
#  id         :bigint           not null, primary key
#  action     :integer          not null
#  message    :string           not null
#  read       :boolean          default(FALSE)
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_notifications_on_action   (action)
#  index_notifications_on_read     (read)
#  index_notifications_on_user_id  (user_id)
#
FactoryBot.define do
  factory :notification do
    action { 'new_follower' }
    message { 'new follower' }
    read { false }

    association :user, factory: :user
  end
end
