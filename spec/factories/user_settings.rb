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
FactoryBot.define do
  factory :user_setting do
    category { UserSetting::USER_SETTING_CATEGORIES[:matecito_default_value] }
    value { '40' }

    association :user, factory: :user
  end
end
