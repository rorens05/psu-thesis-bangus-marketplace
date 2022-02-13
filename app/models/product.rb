class Product < ApplicationRecord
  has_one_attached :image

  has_many :reviews, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  has_many :product_stocks, dependent: :destroy
  enum category: [:best_seller, :featured, :popular]
  
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :wholesale_price, presence: true
  validates :wholesale_minimum_quantity, presence: true

  before_save :refresh_stocks

  def refresh_stocks
    self.stocks = product_stocks.sum(:quantity) - order_items.sum(:quantity)
  end
end
