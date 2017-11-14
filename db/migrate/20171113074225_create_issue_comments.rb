class CreateIssueComments < ActiveRecord::Migration[5.1]
  def change
    create_table :issue_comments do |t|
      t.references :user, null: false
      t.string :issue_id, null: false
      t.text :content, null: false
      t.datetime :created_at, null: false
    end

    add_foreign_key :issue_comments, :users
    add_foreign_key :issue_comments, :issues
  end
end
