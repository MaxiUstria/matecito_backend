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
require 'rails_helper'

RSpec.describe UserFollower, type: :model do
  describe 'validations' do
    subject { build :user_follower }

    it { is_expected.to validate_uniqueness_of(:follower).scoped_to(:user_id).case_insensitive }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:follower).class_name('User') }
  end
end
