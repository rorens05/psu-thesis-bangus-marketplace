class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :status
      t.text :note
      t.string :contact_number
      t.string :address

      t.timestamps
    end
  end
end
