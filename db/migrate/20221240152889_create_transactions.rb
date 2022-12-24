class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string  :uuid, unique: true, null: :false
      t.string  :customer_email, null: :false, default: ''
      t.string  :type, null: :false
      t.string  :status, null: :false
      t.decimal :amount, precision: 13, scale: 4
      t.string  :customer_phone
      t.references :merchant, index: true
      t.timestamps
    end
  end
end
