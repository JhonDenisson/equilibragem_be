class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:post_user]
  def post_user
    authorize User
    schema = Users::PostUserSchema.new
    data = schema.call(params.to_unsafe_h)
    if data.success?
      data = data.to_h
      user = User.new(data)
      if user.save
        payload = { user_id: user.id }
        token = Authentication.encode(payload)
        render json: { token: token }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: data.errors.to_h }, status: :unprocessable_entity
    end
  end
end
