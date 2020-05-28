class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_products

  validates :previous_id, presence: true, uniqueness: true
  validates :date, presence: true
  validates :customer, presence: true

  def total_price
    
  end
end
