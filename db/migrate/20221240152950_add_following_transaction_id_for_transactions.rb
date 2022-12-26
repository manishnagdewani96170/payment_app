class AddFollowingTransactionIdForTransactions < ActiveRecord::Migration[6.1]
  def change
  	add_column :transactions, :following_transaction_id, :integer
  end
end
