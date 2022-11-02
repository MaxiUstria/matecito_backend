# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  allow_password_change  :boolean          default(FALSE)
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  first_name             :string           default("")
#  last_name              :string           default("")
#  username               :string           default("")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  tokens                 :json
#  description            :text
#  is_npo?                :boolean
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#  index_users_on_username              (username) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :social_networks, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :user_settings, dependent: :destroy
  has_many :objectives, dependent: :destroy
  has_many :user_categories, dependent: :destroy
  has_many :categories, through: :user_categories

  has_one_attached :avatar
  has_one_attached :banner

  validates :uid, uniqueness: { scope: :provider }
  validates :avatar, blob: { content_type: :image, size_range: 1..(5.megabytes) }
  validates :banner, blob: { content_type: :image, size_range: 1..(5.megabytes) }

  before_validation :init_uid

  after_create :set_default_user_settings

  def full_name
    return username if first_name.blank?

    "#{first_name} #{last_name}"
  end

  def self.from_social_provider(provider, user_params)
    where(provider:, uid: user_params['id']).first_or_create! do |user|
      user.password = Devise.friendly_token[0, 20]
      user.assign_attributes user_params.except('id')
    end
  end

  private

  def init_uid
    self.uid = email if uid.blank? && provider == 'email'
  end

  def set_default_user_settings
    user_settings.create!(category: UserSetting::USER_SETTING_CATEGORIES[:matecito_default_value],
                          value: '80')
    user_settings.create!(
      category: UserSetting::USER_SETTING_CATEGORIES[:default_thank_you_message],
      value: 'Muchas gracias por tu donación!'
    )
  rescue StandardError => e
    Sentry.capture_exception(e)
    raise ActiveRecord::Rollback
  end
end
