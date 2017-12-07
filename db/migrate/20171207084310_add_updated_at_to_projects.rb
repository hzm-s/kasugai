class AddUpdatedAtToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :updated_at, :datetime, null: false, default: -> { 'NOW()' }
  end
end
