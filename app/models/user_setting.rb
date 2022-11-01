# == Schema Information
#
# Table name: user_settings
#
#  id         :bigint           not null, primary key
#  category   :integer          default(0), not null
#  value      :string           not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_settings_on_user_id  (user_id)
#
class UserSetting < ApplicationRecord
  USER_SETTING_CATEGORIES = {
    matecito_default_value: 0,
    default_thank_you_message: 1
  }.freeze

  belongs_to :user

  validates :value, presence: true

  enum category: USER_SETTING_CATEGORIES
end
