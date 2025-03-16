class Api::InvoicesController < Api::ApiController
  def index
    invoices = Invoice.all
    render json: invoices
  end

  def create
    ActiveRecord::Base.transaction do
      invoice = Invoice.new(invoice_params)

      invoice.raw_data = params.require(:invoice).permit(
        :invoice_number, :date, :due_date, :notes, :template, :invoice_type, :template_config,
        from: [ :name, :email, :address ],
        to: [ :name, :email, :address ],
        items: [ :id, :quantity, :price, :amount, :description ]
      ).to_h

      if invoice.save
        render json: invoice, status: :created
      else
        render json: invoice.errors.full_messages, status: :unprocessable_entity
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def invoice_params
    params.require(:invoice).permit(
      :invoice_number, :date, :due_date, :notes, :template, :invoice_type, :template_config,
      from: [ :name, :email, :address ],
      to: [ :name, :email, :address ],
      items_attributes: [ :quantity, :price, :amount, :description ]
  )
  end
end
