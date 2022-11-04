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
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    subject { build :post }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_least(5).is_at_most(50) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:body).is_at_least(10).is_at_most(5000) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_one_attached(:image) }
  end

  describe 'scopes' do
    let!(:user) { create :user }
    let!(:post1) { create :post, user: }
    let!(:post2) { create :post, user: }
    let!(:post3) { create :post, user: }

    it 'returns the last 2 posts' do
      expect(Post.last(2)).to eq([post2, post3])
    end
  end

  describe 'callbacks' do
    let(:user) { create :user }
    let(:post) { create :post, user: }

    it 'enqueues a job to create a notification' do
      expect {
        post
      }.to have_enqueued_job(CreatePostNotificationJob)
        .with(user, 'new_post', "#{user.full_name} ha publicado un nuevo post!")
    end
  end
end
