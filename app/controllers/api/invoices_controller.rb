class Api::InvoicesController < ApplicationController
  def index
    invoices = Invoice.all
    render json: invoices
  end

  def create
    ActiveRecord::Base.transaction do
      invoice = Invoice.new(invoice_params)

      invoice.raw_data = params.permit!.to_h

      if invoice.save
        render json: invoice, status: :created
      else
        render json: invoice.errors.full_message, status: :unprocessable_entity
      end
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def invoice_params
    params.require(:invoice).permit(
      :invoice_number, :date, :due_date, :notes, :template, :invoice_type, :template_config,
      from: [ :name, :email, :address ],
      to: [ :name, :email, :address ],
      items: [ :id, :quantity, :price, :amount, :description ]
  )
  end
end
