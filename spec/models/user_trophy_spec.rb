# == Schema Information
#
# Table name: user_trophies
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE), not null
#  user_id    :bigint           not null
#  trophy_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_trophies_on_trophy_id              (trophy_id)
#  index_user_trophies_on_user_id                (user_id)
#  index_user_trophies_on_user_id_and_trophy_id  (user_id,trophy_id) UNIQUE
#
require 'rails_helper'

RSpec.describe UserTrophy, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:trophy) }
  end

  describe 'factory' do
    it { expect(build(:user_trophy)).to be_valid }
  end
end
