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
require 'rails_helper'

RSpec.describe Trophy, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:user_trophy).dependent(:destroy) }
    it { is_expected.to have_many(:users).through(:user_trophy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:category).with_values({ bronze: 0, silver: 1, gold: 2 }) }
  end

  describe 'factory' do
    it { expect(build(:trophy)).to be_valid }
  end
end
