class Transaction < ApplicationRecord
  
  # Constants
  STATUSES = %w(approved reversed refunded error)

  # Validations
  validates :customer_email, :uuid, presence: true
  validates :uuid, uniqueness: true
  validates :amount, numericality: { greater_than: 0, allow_nil: true }
  validates :status, presence: true, inclusion: { in: STATUSES }

  # Associations
  belongs_to :merchant, optional: false

  # Scopes
  scope :approved, -> { where(status: 'approved') }
  scope :reversed, -> { where(status: 'reversed') }
  scope :refunded, -> { where(status: 'refunded') }
  scope :error, -> { where(status: 'error') }
  scope :older_than, -> (duration) { where("created_at < ?", Time.now - duration) }

  # Class Methods
  def self.delete_past_records(duration)
    older_than(duration).destroy_all
  end

end
