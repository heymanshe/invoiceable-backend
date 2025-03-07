class Item < ApplicationRecord
  belongs_to :invoice

  validates :quantity, :price, :amount, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  validates :price, :amount, numericality: { greater_than_or_equal_to: 0 }
end
