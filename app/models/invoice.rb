class Invoice < ApplicationRecord
  validates :invoice_number, presence: true, uniqueness: true
  validates :date, :due_date, presence: true
  validates :invoice_type, presence: true
  validates :total_amount, numericality: { greater_than_or_equal_to: 0 }

  before_save :calculate_total_amount

  private

  def calculate_total_amount
    self.total_amount = items.sum(&:amount)
  end
end
