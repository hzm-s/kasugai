class CreateIssuePriorities < ActiveRecord::Migration[5.1]
  def change
    create_table :issue_priorities do |t|
      t.string :project_id, null: false
      t.string :issue_id, null: false
      t.integer :priority_order
    end

    add_index :issue_priorities, :issue_id, unique: true
    add_foreign_key :issue_priorities, :projects
    add_foreign_key :issue_priorities, :issues
  end
end
