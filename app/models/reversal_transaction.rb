class ReversalTransaction < Transaction
  
  # Associations
  belongs_to :following_transaction, class_name: 'AuthorizeTransaction'

  # Callbacks
  after_create :update_following_transaction_record

  private

  def update_following_transaction_record
    following_transaction.update(status: 'reversed')
  end
end
