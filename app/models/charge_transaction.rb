class ChargeTransaction < Transaction

  # Associations
  has_one :follower_transaction, class_name: 'Transaction', foreign_key: 'following_transaction_id'
  belongs_to :following_transaction, -> { where(status: ['approved', 'refunded']) }, class_name: 'AuthorizeTransaction'

  # Callbacks
  after_create :update_merchant_total_transaction_sum

  private

  def update_merchant_total_transaction_sum
    merchant.update(total_transaction_sum: merchant.total_transaction_sum + amount) if approved?
  end
end
