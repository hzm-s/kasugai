class CreateClosedIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :closed_issues do |t|
      t.string :issue_id, null: false, unique: true
      t.datetime :created_at, null: false
    end

    add_index :closed_issues, :issue_id, unique: true
    add_foreign_key :closed_issues, :issues
  end
end
