class AddColumnsToDevices < ActiveRecord::Migration[6.1]
  def change
    add_column :admins, :username, :string, unique: true, null: false
    add_column :admins, :firstname, :string
    add_column :admins, :lastname, :string
    add_column :admins, :age, :integer
  end
end
