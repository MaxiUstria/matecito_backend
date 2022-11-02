# == Schema Information
#
# Table name: user_categories
#
#  id          :bigint           not null, primary key
#  user_id     :bigint           not null
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_user_categories_on_category_id              (category_id)
#  index_user_categories_on_user_id                  (user_id)
#  index_user_categories_on_user_id_and_category_id  (user_id,category_id) UNIQUE
#
require 'rails_helper'

RSpec.describe UserCategory, type: :model do
  describe 'validations' do
    subject { build :user_category }

    it { is_expected.to validate_uniqueness_of(:category).scoped_to(:user_id).case_insensitive }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:category) }
  end
end
