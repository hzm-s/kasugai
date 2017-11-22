class CreateOpenedIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :opened_issues do |t|
      t.string :project_id, null: false
      t.string :issue_id, null: false
      t.integer :priority_order
    end

    add_index :opened_issues, :issue_id, unique: true
    add_foreign_key :opened_issues, :issues
  end
end
