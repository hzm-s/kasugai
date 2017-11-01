class CreateReceptions < ActiveRecord::Migration[5.1]
  def change
    create_table :receptions do |t|
      t.string :token, null: false, unique: true
      t.string :email, null: false, unique: true
      t.datetime :created_at, null: false
    end
  end
end
