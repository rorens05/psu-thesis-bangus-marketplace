class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.decimal :wholesale_price
      t.string :wholesale_minimum_quantity
      t.integer :stocks

      t.timestamps
    end
  end
end
