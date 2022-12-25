class RefundTransaction < Transaction
  
  # Callbacks
  after_create :update_merchant_total_transaction_sum

  private

  def update_merchant_total_transaction_sum
    merchant.update(total_transaction_sum: merchant.total_transaction_sum - amount) if approved?
  end
end
