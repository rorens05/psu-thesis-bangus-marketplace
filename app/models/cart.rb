class Cart < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :user, presence: true
  validates :product, presence: true
  validates :quantity, presence: true
  validates :price, presence: true

  def total
    price || 0 * quantity || 0
  end

  def self.subtotal
    self.all.reduce(0) { |sum, cart| sum + (cart.price * cart.quantity) }
  end
end
