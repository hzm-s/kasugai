class CreateClosedIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :closed_issues do |t|
      t.references :closed_issue_list, null: false, foreign_key: true
      t.string :issue_id, null: false

      t.datetime :created_at, null: false
    end

    add_index :closed_issues, [:closed_issue_list_id, :issue_id], unique: true, name: 'index_closed_issues_on_list_id_and_id'
    add_foreign_key :closed_issues, :issues
  end
end
