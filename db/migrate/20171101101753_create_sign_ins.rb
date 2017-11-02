class CreateSignIns < ActiveRecord::Migration[5.1]
  def change
    create_table :sign_ins do |t|
      t.string :token, null: false
      t.string :email, null: false
      t.datetime :created_at, null: false
    end

    add_index :sign_ins, :token, unique: true
    add_index :sign_ins, :email, unique: true
  end
end
