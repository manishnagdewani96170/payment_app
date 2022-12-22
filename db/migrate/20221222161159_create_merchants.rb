class CreateMerchants < ActiveRecord::Migration[6.1]
  def change
    create_table :merchants do |t|
      t.string  :name, null: :false, default: ''
      t.text    :description 
      t.string  :email, null: false, index: true, unique: :true
      t.string  :status, null: false
      t.decimal :total_transaction_sum, precision: 13, scale: 4, default: 0.0
      t.timestamps
    end
  end
end
