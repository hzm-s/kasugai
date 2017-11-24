class CreateRememberedUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :remembered_users do |t|
      t.references :user, null: false, index: { unique: true }, foreign_key: true
      t.datetime :created_at, null: false
    end
  end
end
