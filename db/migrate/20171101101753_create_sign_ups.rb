class CreateSignUps < ActiveRecord::Migration[5.1]
  def change
    create_table :sign_ups do |t|
      t.references :reception, null: false
      t.string :name, null: false
      t.datetime :created_at, null: false
    end
  end
end
