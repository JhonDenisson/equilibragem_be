class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:post_user]
  def post_user
    user = User.new(user_params)
    if user.save
      payload = { user_id: user.id }
      token = Authentication.encode(payload)
      render json: { user: PostUserSerializer.new(user), token: token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
