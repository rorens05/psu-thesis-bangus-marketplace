class Product < ApplicationRecord
  has_one_attached :image

  has_many :reviews, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :wholesale_price, presence: true
  validates :wholesale_minimum_quantity, presence: true
  validates :stocks, presence: true
  


end
