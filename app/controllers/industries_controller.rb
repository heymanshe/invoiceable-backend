class IndustriesController < ApplicationController
  before_action :find_Industry, only: [ :show, :destroy, :update ]

  def index
    @industries = Industry.all
    render json: @industries
  end

  def show
    render json: @industry
  end

  def create
    @industry = Industry.new(industry_params)
    if @industry.save!
      render json: @industry, status: :created
    else
      render json: { errors: @industry.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def update
    if @industry.update(industry_params)
      render json: @industry
    else
      render json: @industry.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @industry
      @industry.destroy
      head :no_content
    else
      render json: { error: "Industry not found" }, status: :not_found
    end
  end

  private

  def find_Industry
    @industry = Industry.find_by(id: params[:id])
    render json: { error: "Industry not found" }, status: :not_found unless @industry
  end

  def industry_params
    params.permit(:name)
  end
end
