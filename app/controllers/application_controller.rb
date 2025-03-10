class ApplicationController < ActionController::API
  before_action :authorize_request

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
