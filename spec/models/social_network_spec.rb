# == Schema Information
#
# Table name: social_networks
#
#  id         :bigint           not null, primary key
#  url        :string           not null
#  app        :integer          not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_social_networks_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe SocialNetwork, type: :model do
  describe 'validations' do
    subject { build :social_network }
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_presence_of(:app) }

    context 'when url is not valid' do
      let!(:social_network) { build :social_network, url: 'https://www./matecito_app' }

      it 'is not valid' do
       expect(social_network.save).to be_falsey
      end
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'enums' do
    it {
      is_expected.to define_enum_for(:app).with_values({ facebook: 0, twitter: 1, instagram: 2,
                                                         linkedin: 3, youtube: 4, tiktok: 5,
                                                         twitch: 6, onlyfans: 7, github: 8 })
    }
  end
end
