class CreateEmailSignIns < ActiveRecord::Migration[5.1]
  def change
    create_table :email_sign_ins do |t|
      t.references :user, null: false, foreign_key: true
      t.string :email, null: false, unique: true
    end
  end
end
