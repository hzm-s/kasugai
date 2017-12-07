class AddUpdatedAtToIssues < ActiveRecord::Migration[5.1]
  def change
    add_column :issues, :updated_at, :datetime, null: false, default: -> { 'NOW()' }
  end
end
