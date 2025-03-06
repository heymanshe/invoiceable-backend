class CreateInvoices < ActiveRecord::Migration[8.0]
  def change
    create_table :invoices do |t|
      t.string :invoice_number
      t.string :invoice_type
      t.jsonb :from
      t.jsonb :to
      t.decimal :total_amount
      t.string :template
      t.text :template_config
      t.date :due_date
      t.date :date
      t.text :notes
      t.jsonb :raw_data

      t.timestamps
    end
  end
end
