class ApplicationController < ActionController::Base
  # protect_from_forgery with: :null_session, if: -> { request.format.json? }

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authorize_request

  wrap_parameters format: []

  def not_found
    render json: { error: "not_found" },  status: :not_found
  end

  def authorize_request
    header = request.headers["Authorization"]
    token = header.split(" ").last if header.present?

    if token.present?
      begin
        @decoded = JsonWebToken.decode(token)
        @current_user = User.find_by(id: @decoded[:user_id])
        render_unauthorized unless @current_user
      rescue JWT::DecodeError => e
        render_unauthorized(e.message)
      end
    else
      render_unauthorized
    end
  end

  def render_unauthorized(message = "Unauthorized")
    render json: { error: message }, status: :unauthorized
  end
end
