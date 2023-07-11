class AddNameAndHeadersOrderToMigrations < ActiveRecord::Migration[7.0]
  def change
    add_column :migrations, :name, :string
    add_column :migrations, :import_headers_order, :string
  end
end
