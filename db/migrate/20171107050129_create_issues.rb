class CreateIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :issues, id: :string do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :content

      t.timestamps
    end
  end
end
