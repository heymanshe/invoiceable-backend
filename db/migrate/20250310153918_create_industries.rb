class CreateIndustries < ActiveRecord::Migration[8.0]
  def change
    create_table :industries do |t|
      t.string :name

      t.timestamps
    end
    add_index :industries, :name, unique: true
  end
end
