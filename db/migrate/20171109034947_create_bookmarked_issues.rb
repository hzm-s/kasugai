class CreateBookmarkedIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :bookmarked_issues do |t|
      t.references :bookmarked_issue_list, foreign_key: true
      t.references :opened_issue, null: false, foreign_key: true
      t.datetime :created_at, null: false
    end

    add_index :bookmarked_issues, [:bookmarked_issue_list_id, :opened_issue_id], unique: true, name: 'index_bookmarked_issues_on_list_id_and_opened_id'
  end
end
