class CreateIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :issues do |t|
      t.string :project_id, null: false
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :content
      t.datetime :created_at, null: false
    end

    add_foreign_key :issues, :projects
  end
end
