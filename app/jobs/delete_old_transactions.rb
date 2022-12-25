class DeleteOldTransactions < ApplicationJob

  def perform
    # Delete transactions older than 1 hr(3600)
    Transaction.delete_past_records(3600)
  end
end
