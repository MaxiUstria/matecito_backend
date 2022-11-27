describe 'GET api/v1/users/:username', type: :request do
  let(:user) { create(:user) }
  let!(:username) { user.username }
  let(:donations) { create_list(:donation, 3, beneficiary: user) }
  let(:social_networks) { create(:social_network, user: user) }

  subject { get profile_api_v1_user_path(username), as: :json }

  before do
    subject
  end

  context 'when the user is authenticated' do
    let(:auth_headers) { user.create_new_auth_token }

    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the user' do
        byebug
      expect(json[:user][:username]).to eq(user.username)
      expect(json[:user][:first_name]).to eq(user.first_name)
      expect(json[:user][:last_name]).to eq(user.last_name)
    end

    context 'when the username is not correct' do
      let(:username) { 'invalid_username' }

      it 'does not return a successful response' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  context 'when the user is not authenticated' do
    let(:auth_headers) { {} }

    it 'return a successful response' do
      expect(response).to have_http_status(:success)
    end
  end

  context 'when the user has social networks' do
    it 'returns the user' do
      expect(json[:user][:social_networks].count).to eq(user.social_networks.count)
    end
  end

  context 'when the user has donations' do
    let(:donation) { create(:donation, beneficiary: user) }

    it 'returns the user' do
      expect(json[:user][:donations].count).to eq(Donation.where(beneficiary_id: user.id).count)
    end
  end
end
