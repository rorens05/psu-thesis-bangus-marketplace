class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  
  after_save :refresh_product_stock

  def refresh_product_stock
    product.refresh_stocks
    product.save
  end
end
