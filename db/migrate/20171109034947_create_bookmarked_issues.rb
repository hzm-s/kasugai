class CreateBookmarkedIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :bookmarked_issues do |t|
      t.references :bookmarked_issue_list, index: true, foreign_key: true
      t.string :issue_id, null: false
      t.datetime :created_at, null: false
    end

    add_index :bookmarked_issues, [:bookmarked_issue_list_id, :issue_id], unique: true, name: 'index_bookmarked_issues_on_list_id_and_id'
    add_foreign_key :bookmarked_issues, :issues
  end
end
