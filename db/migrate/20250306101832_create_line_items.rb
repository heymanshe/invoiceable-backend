class CreateLineItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.references :invoice, null: false, foreign_key: true
      t.integer :quantity, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.text :description

      t.timestamps
    end
  end
end
