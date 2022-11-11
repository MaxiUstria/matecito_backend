require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /posts', type: :request do
    subject { get api_v1_posts_path(user_id: user.id), headers: auth_headers, as: :json }

    let(:user) { create(:user) }
    let(:headers) { user.create_new_auth_token }

    context 'when there are no posts' do
      it 'returns an empty array' do
        subject
        expect(json['posts']).to be_empty
      end
    end

    context 'when there are posts' do
      let!(:posts) { create_list(:post, 3, user:) }

      it 'returns the posts' do
        subject
        expect(json['posts'].size).to eq 3
      end
    end

    context 'when there are posts from other users' do
      let!(:user2) { create(:user) }
      let!(:posts) { create_list(:post, 3, user: user2) }

      it 'does not return the posts' do
        subject
        expect(json['posts']).to be_empty
      end
    end
  end

  describe 'GET /posts/:id', type: :request do
    subject do
      get api_v1_post_path(id: post_id, user_id: user.id), headers: auth_headers, as: :json
    end

    let(:user) { create(:user) }
    let(:headers) { user.create_new_auth_token }
    let(:post) { create(:post, user:) }
    let(:post_id) { post.id }

    it 'returns the post' do
      subject
      expect(json[:post][:id]).to eq post.id
    end

    context 'when the post does not exist' do
      let(:post_id) { 0 }

      it 'returns a not found response' do
        subject
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when the post belongs to another user' do
      let(:user2) { create(:user) }
      let(:post) { create(:post, user: user2) }

      it 'returns a not found response' do
        subject
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /posts', type: :request do
    subject { post api_v1_posts_path(user_id: user.id), params:, headers:, as: :json }

    let(:user) { create(:user) }
    let(:headers) { auth_headers }
    let(:params) { { post: attributes_for(:post) } }

    it 'creates the post' do
      expect { subject }.to change(Post, :count).by(1)
    end

    it 'returns the post' do
      subject
      expect(json[:post][:id]).to eq Post.last.id
    end

    context 'when the params are invalid' do
      let(:params) { { post: attributes_for(:post, title: nil) } }

      it 'does not create the post' do
        expect { subject }.not_to change(Post, :count)
      end

      it 'returns an error' do
        subject
        expect(json[:errors]).to be_present
      end
    end

    context 'when the user is not authenticated' do
      let(:headers) { {} }

      it 'does not create the post' do
        expect { subject }.not_to change(Post, :count)
      end

      it 'returns an unauthorized response' do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PUT /posts/:id', type: :request do
    subject do
      put api_v1_post_path(id: post_id, user_id: user.id), params:, headers:, as: :json
    end

    let(:user) { create(:user) }
    let(:post_id) { post.id }
    let(:headers) { auth_headers }
    let(:post) { create(:post, user:) }
    let(:params) { { post: attributes_for(:post) } }

    it 'updates the post' do
      subject
      expect(post.reload.title).to eq params[:post][:title]
    end

    it 'returns the post' do
      subject
      expect(json[:post][:id]).to eq post.id
    end

    context 'when the params are invalid' do
      let(:params) { { post: attributes_for(:post, title: nil) } }

      it 'does not update the post' do
        subject
        expect(post.reload.title).not_to be_nil
      end

      it 'returns an error' do
        subject
        expect(json[:errors]).to be_present
      end
    end

    context 'when the user is not authenticated' do
      let(:headers) { {} }

      it 'does not update the post' do
        subject
        expect(post.reload.title).not_to eq params[:post][:title]
      end

      it 'returns an unauthorized response' do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when the post does not exist' do
      let(:post_id) { 0 }

      it 'returns a not found response' do
        subject
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when the post belongs to another user' do
      let!(:user2) { create(:user) }
      let(:post) { create(:post, user: user2) }

      it 'returns a not found response' do
        subject
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
