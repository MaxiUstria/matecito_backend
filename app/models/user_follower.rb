# == Schema Information
#
# Table name: user_followers
#
#  id          :bigint           not null, primary key
#  follower_id :bigint           not null
#  user_id     :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_user_followers_on_follower_id              (follower_id)
#  index_user_followers_on_follower_id_and_user_id  (follower_id,user_id) UNIQUE
#  index_user_followers_on_user_id                  (user_id)
#
class UserFollower < ApplicationRecord
  belongs_to :user
  belongs_to :follower, class_name: 'User'

  validates :follower, uniqueness: { scope: :user_id }
end
