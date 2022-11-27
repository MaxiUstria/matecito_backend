module Api
  module V1
    class PostsController < Api::V1::ApiController
      before_action :authenticate_user!, except: %i[index show]
      before_action :set_user_post, only: %i[update destroy]
      before_action :set_post, only: %i[show]
      skip_after_action :verify_authorized
      skip_after_action :verify_policy_scoped

      def index
        byebug
        @posts = Post.where(user_id: params[:user_id]).includes([image_attachment: :blob])
      end

      def show; end

      def create
        @post = current_user.posts.create!(post_params)
        render :show
      end

      def update
        @post.update!(post_params)
        render :show
      end

      def destroy
        @post.destroy!
      end

      private

      def set_post
        @post = Post.where(user_id: params[:user_id]).find(params[:id])
      end

      def set_user_post
        @post = current_user.posts.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:title, :body, :url, :category, :image)
      end
    end
  end
end
