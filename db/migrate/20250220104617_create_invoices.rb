class CreateInvoices < ActiveRecord::Migration[8.0]
  def change
    create_table :invoices do |t|
      t.string :title
      t.decimal :amount
      t.string :status

      t.timestamps
    end
  end
end
