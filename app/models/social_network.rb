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
#  index_social_networks_on_user_id          (user_id)
#  index_social_networks_on_user_id_and_app  (user_id,app) UNIQUE
#
class SocialNetwork < ApplicationRecord
  REGEXP = {
    'facebook': %r{\Ahttps://www.facebook.com/.+\z},
    'twitter': %r{\Ahttps://twitter.com/.+\z},
    'linkedin': %r{\Ahttps://www.linkedin.com/in/.+\z},
    'github': %r{\Ahttps://github.com/.+\z},
    'instagram': %r{\Ahttps://www.instagram.com/.+\z},
    'youtube': %r{\Ahttps://www.youtube.com/.+\z},
    'tiktok': %r{\Ahttps://www.tiktok.com/.+\z},
    'twitch': %r{\Ahttps://www.twitch.tv/.+\z},
    'onlyfans': %r{\Ahttps://onlyfans.com/.+\z}
  }.freeze

  belongs_to :user

  validates :url, presence: true
  validates :app, presence: true
  
  before_save :url_match_regexp

  enum app: { facebook: 0, twitter: 1, instagram: 2, linkedin: 3, youtube: 4, tiktok: 5,
              twitch: 6, onlyfans: 7, github: 8 }

  private

  def url_match_regexp
    throw :abort unless url.match?(REGEXP[app.to_sym])
  end
end
