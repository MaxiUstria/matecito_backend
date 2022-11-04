class CreatePostNotificationJob < ApplicationJob
  queue_as :default

  def perform(user, action, message)
    user.followers.each do |follower|
      follower.notifications.create!(action:, message:)
    end
  end
end
