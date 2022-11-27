module Api
  module V1
    class UsersController < Api::V1::ApiController
      skip_before_action :authenticate_user!, only: %i[profile]
      before_action :auth_user, except: %i[profile]
      skip_after_action :verify_authorized
      skip_after_action :verify_policy_scoped

      def show; end

      def profile
        @user = User.find_by!(username: params[:username])
      end

      def update
        current_user.update!(user_params)
        render :show
      end

      private

      def auth_user
        authorize current_user
      end

      def user_params
        params.require(:user).permit(:username, :first_name, :last_name, :email)
      end
    end
  end
end
