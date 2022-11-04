require 'rails_helper'

RSpec.describe CreatePostNotificationJob, type: :job do
  describe '#perform_later' do
    let(:user) { create(:user) }
    let(:action) { 'new_post' }
    let(:message) { 'New post!' }
    let(:notification) { create(:notification, user:, action:, message:) }

    it 'queues the job' do
      expect {
        CreatePostNotificationJob.perform_later(user, action,
                                                message)
      }.to have_enqueued_job(CreatePostNotificationJob)
    end
  end
end
