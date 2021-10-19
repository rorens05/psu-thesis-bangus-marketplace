class Message < ApplicationRecord
  has_one_attached :attachment
  belongs_to :admin_user
  belongs_to :user

  enum sender: [:admin_user, :user]
end
