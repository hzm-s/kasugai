class AddUpdatedAtToIssueComments < ActiveRecord::Migration[5.1]
  def change
    add_column :issue_comments, :updated_at, :datetime, null: false, default: -> { 'NOW()' }
  end
end
