class CreateIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :issues, id: :string do |t|
      t.string :project_id, null: false, index: true
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :content

      t.timestamps
    end

    add_foreign_key :issues, :projects
  end
end
