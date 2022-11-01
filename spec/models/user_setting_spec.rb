# == Schema Information
#
# Table name: user_settings
#
#  id         :bigint           not null, primary key
#  category   :integer          default("matecito_default_value"), not null
#  value      :string           not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_settings_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe UserSetting, type: :model do
  describe 'validations' do
    subject { build :user_setting }

    it { is_expected.to validate_presence_of(:value) }
    it {
      is_expected.to define_enum_for(:category)
        .with_values(UserSetting::USER_SETTING_CATEGORIES.keys)
    }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end
