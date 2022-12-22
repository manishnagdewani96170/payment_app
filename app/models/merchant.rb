class Merchant < ApplicationRecord
  
  # Validations
  validates :name, :email, presence: true
  validates :email, uniqueness: true
  validates :total_transaction_sum, numericality: { greater_than_or_equal_to: 0 }
  validates :status, inclusion: { in: %w(active inactive), message: "%{value} is not a valid status" }

  # Scope
  scope :active, -> { where(status: 'active') }
end

