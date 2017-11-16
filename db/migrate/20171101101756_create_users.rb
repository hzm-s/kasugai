class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :initials, null: false
      t.string :theme, null: false
    end
  end
end
