class AddSenderToMessage < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :sender, :integer
  end
end
