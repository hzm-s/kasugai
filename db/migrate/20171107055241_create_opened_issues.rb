class CreateOpenedIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :opened_issues do |t|
      t.references :issue_list, null: false, foreign_key: true
      t.string :issue_id, null: false
      t.integer :priority_order

      t.timestamps
    end

    add_index :opened_issues, [:issue_list_id, :issue_id], unique: true
    add_foreign_key :opened_issues, :issues
  end
end
