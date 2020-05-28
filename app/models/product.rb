class Product < ApplicationRecord
  has_many :order_products

  validates :code, presence: true, uniqueness: true
  validates :description, presence: true
  validates :unit_price, presence: true
end
