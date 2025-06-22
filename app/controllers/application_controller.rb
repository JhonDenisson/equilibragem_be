class ApplicationController < ActionController::API
  before_action :authenticate_request

  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
  def authenticate_request
    header = request.headers["Authorization"]
    header = header.split("Bearer ").last if header
    decoded = Authentication.decode(header)

    if decoded
      @current_user = User.find_by(id: decoded[:user_id])
      render json: { error: "User not found" }, status: :unauthorized unless @current_user
    else
      render json: { error: "Invalid token" }, status: :unauthorized
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: :unauthorized
  end

  def user_not_authorized
    render json: { error: "You are not authorized to perform this action" }, status: :forbidden
  end

  def current_user
    @current_user
  end
end
