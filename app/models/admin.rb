class Admin < ApplicationRecord
   # Constants
  STATUSES = %w(active inactive)

  # Validations
  validates :name, :email, presence: true
  validates :email, uniqueness: true
  validates :status, inclusion: { in: STATUSES, message: "%{value} is not a valid status" }

  # Scope
  scope :active, -> { where(status: 'active') }
end
