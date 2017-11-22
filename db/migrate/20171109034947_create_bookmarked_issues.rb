class CreateBookmarkedIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :bookmarked_issues do |t|
      t.string :issue_id, null: false
      t.datetime :created_at, null: false
    end

    add_index :bookmarked_issues, :issue_id, unique: true
    add_foreign_key :bookmarked_issues, :issues
  end
end
