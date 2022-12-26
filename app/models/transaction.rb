class Transaction < ApplicationRecord
  
  # Constants
  STATUSES = %w(approved reversed refunded error)

  # Validations
  validates :customer_email, :uuid, presence: true
  validates :uuid, uniqueness: true
  validates :status, presence: true, inclusion: { in: STATUSES }
  validate  :nil_or_invalid_amount

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

  # Instance Methods
  def approved?
    status == 'approved'
  end

  def refunded?
    status == 'refunded'
  end

  def reversed?
    status == 'reversed'
  end

  private

  def nil_or_invalid_amount
    if self.type == 'ReversalTransaction' && !amount.nil?
      errors.add :amount, 'should not be present for this transaction'
    elsif self.type != 'ReversalTransaction' && (amount.nil? || amount <= 0)
      errors.add :amount, 'cannot be empty or less than 0 for this transaction'
    end
  end
end
