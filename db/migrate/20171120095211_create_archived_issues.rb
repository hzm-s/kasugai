class CreateArchivedIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :archived_issues do |t|
      t.string :issue_id, null: false, unique: true
      t.datetime :created_at, null: false
    end

    add_foreign_key :archived_issues, :issues
  end
end
