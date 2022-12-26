class AuthorizeTransaction < Transaction
  
  # Associations
  has_one :follower_transaction, class_name: 'Transaction', foreign_key: 'following_transaction_id'
end
