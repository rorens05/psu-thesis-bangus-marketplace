class CreateMasterLists < ActiveRecord::Migration[6.0]
  def change
    create_table :master_lists do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :share_capital
      t.decimal :withdrawal
      t.decimal :balance
      t.decimal :membership_fee
      t.decimal :consolidation
      t.integer :status

      t.timestamps
    end
  end
end
