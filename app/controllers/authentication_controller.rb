class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request
  def generate_token
    if request.authorization.present?
      authorization = request.authorization
      if params[:grant_type] == "client_credentials"
        credentials = Base64.decode64(authorization.split(" ")[1] || "").split(":")
        if credentials.length == 2
          email, pass = credentials
          user = User.find_by(email: email)
          if user.present?
            if user.authenticate(pass)
              access_token = Authentication.encode({ user_id: user.id })
              render json: { access_token: access_token, token_type: "Bearer", }, status: :ok
            else
              render json: { error: "Invalid credentials" }, status: :unauthorized
            end
          else
            render json: { error: "Access denied" }, status: :forbidden
          end
        else
          render json: { error: "Invalid credentials" }, status: :unauthorized
        end
      else
        render json: { error: "Invalid grant type" }, status: :bad_request
      end
    else
      render json: { error: "Authorization header is missing" }, status: :bad_request
    end
  end
end
