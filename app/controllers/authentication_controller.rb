class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request
  def generate_token
    if params[:grant_type] == "password"
      user = User.find_by(email: params[:username])
      return render json: { error: "user_not_found", error_description: "User not found" }, status: :not_found unless user.present?

      if user.authenticate(params[:password])
        access_token = Authentication.encode({ user_id: user.id })
        render json: {
          access_token: access_token,
          token_type: "Bearer",
          expires_in: 24.hours.to_i,
          user: { id: user.id, name: user.name, email: user.email }
        }, status: :ok
      else
        render json: { error: "invalid_grant", error_description: "Invalid user credentials" }, status: :unauthorized
      end
    else
      render json: { error: "unsupported_grant_type", error_description: "Grant type not supported" }, status: :bad_request
    end
  end
end
