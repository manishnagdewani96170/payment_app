class Merchant < ApplicationRecord
  
  # Constants
  STATUSES = %w(active inactive)

  # Validations
  validates :name, :email, presence: true
  validates :email, uniqueness: true
  validates :total_transaction_sum, numericality: { greater_than_or_equal_to: 0 }
  validates :status, inclusion: { in: STATUSES, message: "%{value} is not a valid status" }

  # Asscoiations
  has_many :transactions, dependent: :destroy

  # Scope
  scope :active, -> { where(status: 'active') }
end

