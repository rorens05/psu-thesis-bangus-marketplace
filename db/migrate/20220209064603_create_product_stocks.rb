class CreateProductStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :product_stocks do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :quantity
      t.references :admin_user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
