# == Schema Information
#
# Table name: donations
#
#  id             :bigint           not null, primary key
#  amount         :integer          not null
#  currency       :string           default("UY"), not null
#  message        :string
#  beneficiary_id :bigint           not null
#  donor_id       :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_donations_on_beneficiary_id  (beneficiary_id)
#  index_donations_on_donor_id        (donor_id)
#
require 'rails_helper'

RSpec.describe Donation, type: :model do
  describe 'validations' do
    subject { build :donation }

    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_presence_of(:currency) }
    it { is_expected.to validate_length_of(:message).is_at_most(500) }
  end

  context 'when the donation is a user donation' do
    subject { build :user_donation }

    it { is_expected.to validate_presence_of(:donor) }
    it { is_expected.to be_valid }
    it { is_expected.to be_an_instance_of(UserDonation) }
  end

  context 'when the donation is an anonymous donation' do
    subject { build :anonymous_donation }

    it { is_expected.not_to validate_presence_of(:donor) }
    it { is_expected.to be_valid }
    it { is_expected.to be_an_instance_of(AnonymousDonation) }
  end
end
