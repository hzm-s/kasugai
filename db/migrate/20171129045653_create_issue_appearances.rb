class CreateIssueAppearances < ActiveRecord::Migration[5.1]
  def change
    create_table :issue_appearances do |t|
      t.string :issue_id, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true
      t.datetime :created_at, null: false
    end

    add_index :issue_appearances, [:issue_id, :account_id], unique: true
    add_foreign_key :issue_appearances, :issues
  end
end
