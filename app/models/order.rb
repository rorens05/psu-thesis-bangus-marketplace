class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  enum status: [:pending, :processing, :shipping, :completed, :cancelled]
  validates :contact_number, presence: true
  validates :address, presence: true

  def reference_number
    "OR#{id.to_s.rjust(6, '0')}"
  end

  def price
    order_items.reduce(0) { |sum, order_item| sum + (order_item.price * order_item.quantity) }
  end
end
