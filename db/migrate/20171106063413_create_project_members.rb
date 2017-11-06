class CreateProjectMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :project_members do |t|
      t.string :project_id, null: false
      t.references :user, null: false, foreign_key: true
    end

    add_foreign_key :project_members, :projects
    add_index :project_members, [:project_id, :user_id], unique: true
  end
end
