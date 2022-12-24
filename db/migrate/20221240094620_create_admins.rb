class CreateAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :admins do |t|
      t.string  :name, null: :false, default: ''
      t.string  :email, null: false, index: true, unique: :true
      t.string  :status, null: false
      t.timestamps
    end
  end
end
