class CreateProductCategory < ActiveRecord::Migration[6.1]
  def change
    create_table :product_categories do |t|
      t.belongs_to :category
      t.belongs_to :category
      t.timestamps
    end
  end
end
