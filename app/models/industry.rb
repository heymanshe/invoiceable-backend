class Industry < ApplicationRecord
  has_many :templates, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
