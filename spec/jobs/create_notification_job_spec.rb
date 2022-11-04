require 'rails_helper'

RSpec.describe CreateNotificationJob, type: :job do
  describe '#perform_later' do
    let(:user) { create(:user) }
    let(:action) { 'new_post' }
    let(:message) { 'New post!' }
    let(:notification) { create(:notification, user:, action:, message:) }

    it 'queues the job' do
      expect {
        CreateNotificationJob.perform_later(user, action,
                                            message)
      }.to have_enqueued_job(CreateNotificationJob)
    end
  end

  describe '#perform_now' do
    let(:user) { create(:user) }
    let(:action) { 'new_post' }
    let(:message) { 'New post!' }
    let(:notification) { create(:notification, user:, action:, message:) }

    it 'executes perform' do
      expect {
        CreateNotificationJob.perform_now(user, action, message)
      }.to change(Notification, :count).by(1)
    end
  end
end
