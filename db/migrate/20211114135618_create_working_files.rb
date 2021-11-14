class CreateWorkingFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :working_files do |t|
      t.string :or_no
      t.date :or_date
      t.references :master_list, null: false, foreign_key: true
      t.integer :particular
      t.integer :member
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
