class CreateNotificationJob < ApplicationJob
  queue_as :default

  def perform(user, action, message)
    user.notifications.create!(action:, message:)
  end
end
