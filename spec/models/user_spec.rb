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

describe User do
  describe 'validations' do
    subject { build :user }
    it { is_expected.to validate_uniqueness_of(:uid).scoped_to(:provider) }

    context 'when was created with regular login' do
      subject { build :user }
      it { is_expected.to validate_uniqueness_of(:email).case_insensitive.scoped_to(:provider) }
      it { is_expected.to validate_presence_of(:email) }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:social_networks).dependent(:destroy) }
    it { is_expected.to have_many(:posts).dependent(:destroy) }
    it { is_expected.to have_many(:user_settings).dependent(:destroy) }
    it { is_expected.to have_many(:objectives).dependent(:destroy) }
    it { is_expected.to have_many(:categories).through(:user_categories) }
    it { is_expected.to have_many(:user_categories).dependent(:destroy) }
    it { is_expected.to have_many(:followers).through(:user_followers).source(:follower) }
    it { is_expected.to have_many(:user_followers).dependent(:destroy) }
    it { is_expected.to have_many(:notifications).dependent(:destroy) }

    it { is_expected.to have_one_attached(:avatar) }
    it { is_expected.to have_one_attached(:banner) }
    it { is_expected.to have_one_attached(:intro_video) }
  end

  context 'when was created with regular login' do
    let!(:user) { create(:user, first_name: nil, last_name: nil) }
    let(:full_name) { user.full_name }

    it 'returns the correct name' do
      expect(full_name).to eq(user.username)
    end
  end

  context 'when user has first_name' do
    let!(:user) { create(:user, first_name: 'John', last_name: 'Doe') }

    it 'returns the correct name' do
      expect(user.full_name).to eq('John Doe')
    end
  end

  describe '.from_social_provider' do
    context 'when user does not exists' do
      let(:params) { attributes_for(:user) }

      it 'creates the user' do
        expect {
          User.from_social_provider('provider', params)
        }.to change { User.count }.by(1)
      end
    end

    context 'when the user exists' do
      let!(:user)  { create(:user, provider: 'provider', uid: 'user@example.com') }
      let(:params) { attributes_for(:user).merge('id' => 'user@example.com') }

      it 'returns the given user' do
        expect(User.from_social_provider('provider', params))
          .to eq(user)
      end
    end
  end

  describe 'user with images' do
    let!(:user) { create(:user) }

    it 'user is valid' do
      expect(user).to be_valid
    end
  end

  describe 'user callbacks' do
    context 'after create' do
      let!(:user) { create(:user) }

      it 'creates user configs' do
        expect(user.user_settings.count).to eq(2)
      end
    end
  end
end
