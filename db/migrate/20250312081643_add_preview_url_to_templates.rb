class AddPreviewUrlToTemplates < ActiveRecord::Migration[8.0]
  def change
    add_column :templates, :preview_url, :string
  end
end
