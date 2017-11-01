class CreateSignUps < ActiveRecord::Migration[5.1]
  def change
    create_table :sign_ups do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :token, null: false, unique: true
      t.datetime :created_at, null: false
    end
  end
end
