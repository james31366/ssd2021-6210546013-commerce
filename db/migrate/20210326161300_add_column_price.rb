class AddColumnPrice < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :price, :integer
  end
end
