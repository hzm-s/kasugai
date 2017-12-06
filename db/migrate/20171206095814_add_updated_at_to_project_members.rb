class AddUpdatedAtToProjectMembers < ActiveRecord::Migration[5.1]
  def change
    add_column :project_members, :updated_at, :datetime, null: false, default: -> { 'NOW()' }
  end
end
