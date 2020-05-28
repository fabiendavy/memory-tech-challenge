class Customer < ApplicationRecord
  has_many :orders

  validates :previous_id, presence: true, uniqueness: true
  validates :country, presence: true
end
