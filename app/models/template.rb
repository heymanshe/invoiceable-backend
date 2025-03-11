class Template < ApplicationRecord
  belongs_to :industry

  validates :name, presence: true
end
