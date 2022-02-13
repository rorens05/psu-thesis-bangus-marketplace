class ProductStock < ApplicationRecord
  belongs_to :product
  belongs_to :admin_user
  after_save :refresh_product_stock

  validates :quantity, presence: true

  def refresh_product_stock
    product.refresh_stocks
    product.save
  end
end
