class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :update, :destroy ]

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @user
      @user.destroy
      head :no_content
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    render json: { error: "User not found" }, status: :not_found unless @user
  end

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
