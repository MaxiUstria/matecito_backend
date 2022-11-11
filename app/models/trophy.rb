# == Schema Information
#
# Table name: trophies
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  description :string           not null
#  category    :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_trophies_on_name  (name) UNIQUE
#
class Trophy < ApplicationRecord
  has_many :user_trophy, dependent: :destroy
  has_many :users, through: :user_trophy

  validates :name, presence: true
  validates :category, inclusion: { in: %w[bronze silver gold] }

  enum category: { bronze: 0, silver: 1, gold: 2 }
end
