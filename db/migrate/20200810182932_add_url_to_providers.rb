class AddUrlToProviders < ActiveRecord::Migration[5.2]
  def change
    add_column :providers, :url, :string
  end
end
