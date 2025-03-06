class CreateInvoices < ActiveRecord::Migration[8.0]
  def change
    create_table :invoices do |t|
      t.string :invoice_number, null: false
      t.string :invoice_type, null: false
      t.jsonb :from, null: false, default: {}
      t.jsonb :to, null: false, default: {}
      t.decimal :total_amount, precision: 10, scale: 2, default: 0.0
      t.string :template
      t.text :template_config
      t.date :due_date,  null: false
      t.date :date,  null: false
      t.text :notes
      t.jsonb :raw_data, default: {}

      t.timestamps
    end

    add_index :invoices, :invoice_number, unique: true
  end
end
