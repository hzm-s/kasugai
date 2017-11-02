class CreateSignUps < ActiveRecord::Migration[5.1]
  def change
    create_table :sign_ups do |t|
      t.string :token, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.datetime :created_at, null: false
    end

    add_index :sign_ups, :token, unique: true
    add_index :sign_ups, :email, unique: true
  end
end
