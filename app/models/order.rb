class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_products

  validates :previous_id, presence: true, uniqueness: true
  validates :date, presence: true
  validates :customer, presence: true

  def total_price
    order_sum = 0
    order_products.each do |order_product|
      product = Product.find(order_product.product_id)
      order_sum += product.unit_price * order_product.quantity
    end
    order_sum.round(2)
  end
end
