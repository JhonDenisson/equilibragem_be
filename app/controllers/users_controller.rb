class UsersController < ApplicationController
  skip_before_action :authenticate_request
  def post_user
    authorize User
    schema = Users::PostUserSchema.new
    data = schema.call(params.to_unsafe_h)
    if data.success?
      data = data.to_h
      user = User.new(data)
      if user.save
        payload = { user_id: user.id }
        access_token = Authentication.encode(payload)
        render json: {
          success: true,
          access_token: access_token,
          token_type: "Bearer",
          expires_in: 24.hours.to_i,
          user: { id: user.id, name: user.name, email: user.email }
        }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: data.errors.to_h }, status: :unprocessable_entity
    end
  end
end
