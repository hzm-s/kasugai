class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :email, null: false, unique: true
      t.datetime :created_at, null: false
    end
  end
end
