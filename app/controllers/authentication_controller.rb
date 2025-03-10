class AuthenticationController < ApplicationController
  before_action :authorize_request, except: [:login, :register]

  def login
    user = User.find_by(email: login_params[:email])

    if user&.authenticate(login_params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render_success_response(user, token)
    else
      render_error_response
    end
  end

  def register
    user = User.new(user_params)

    if user.save
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token: token, user: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def render_success_response(user, token)
    render json: {
      token: token,
      exp: (Time.current + 24.hours).to_i,
      email: user.email
    }, status: :ok
  end

  def render_error_response
    render json: { error: "Invalid email or password" }, status: :unauthorized
  end
end
