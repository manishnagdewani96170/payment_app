class RefundTransaction < Transaction
  
  # Associations
  belongs_to :following_transaction, -> { where(status: ['approved', 'refunded']) }, class_name: 'ChargeTransaction'

  # Callbacks
  after_create :update_following_transaction_record, :update_merchant_total_transaction_sum

  private

  def update_merchant_total_transaction_sum
    merchant.update(total_transaction_sum: merchant.total_transaction_sum - amount) if approved?
  end

  def update_following_transaction_record
    following_transaction.update(status: 'refunded')
  end
end
