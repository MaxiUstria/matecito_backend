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
class Notification < ApplicationRecord
  belongs_to :user

  validates :message, presence: true
  validates :action, presence: true, inclusion: { in: %w[new_follower new_post new_donation] }

  enum action: { new_follower: 0, new_post: 1, new_donation: 2 }

  scope :unread, -> { where(read: false) }
end
