class AddCategoryToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :category, :integer
  end
end
