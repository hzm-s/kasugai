class CreateProjectUpdates < ActiveRecord::Migration[5.1]
  def change
    create_table :project_updates do |t|
      t.string :project_id, null: false
      t.references :user, null: false, index: true, foreign_key: true
      t.text :detail, null: false
      t.datetime :created_at, null: false
    end

    add_index :project_updates, :project_id
    add_foreign_key :project_updates, :projects
  end
end
