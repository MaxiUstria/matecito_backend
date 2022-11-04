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
class Post < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  validates :title, presence: true, length: { maximum: 50, minimum: 5 }
  validates :body, presence: true, length: { maximum: 5000, minimum: 10 }
  validates :image, blob: { content_type: :image, size_range: 1..(5.megabytes) }

  after_create :create_notification

  private

  def create_notification
    CreatePostNotificationJob.perform_later(user, 'new_post',
                                            "#{user.full_name} ha publicado un nuevo post!")
  end
end
