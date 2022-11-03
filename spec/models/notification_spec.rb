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
require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'validations' do
    subject { build :notification }

    it { is_expected.to validate_presence_of(:message) }
    it { is_expected.to validate_presence_of(:action) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'scopes' do
    describe '.unread' do
      let!(:read_notification) { create :notification, read: true }
      let!(:unread_notification) { create :notification }

      it 'returns only unread notifications' do
        expect(Notification.unread).to eq [unread_notification]
      end
    end
  end

  describe 'enums' do
    it {
      is_expected.to define_enum_for(:action).with_values(%i[new_follower new_post new_donation])
    }
  end
end
