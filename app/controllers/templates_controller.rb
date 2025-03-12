class TemplatesController < ApplicationController

  before_action :find_template, only: [ :show, :update, :destroy ]

  def index
    @templates = Template.all
    render json: @templates
  end

  def show
    render json: @template
  end

  def create
    @template = Template.new(template_params)
    if @template.save!
      render json: @template, status: :created
    else
      render json: { errors: @template.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def update
    if @template.update(template_params)
      render json: @template
    else
      render json: @template.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @template
      @template.destroy
      head :no_content
    else
      render json: { error: "Template not found" }, status: :not_found
    end
  end

  private

  def find_template
    @template = Template.find_by(id: params[:id])
    render json: { error: "Template not found" }, status: :not_found unless @template
  end

  def template_params
    params.permit(:name, :industry_id, :preview_url)
  end
end
