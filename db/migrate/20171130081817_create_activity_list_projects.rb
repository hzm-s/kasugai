class CreateActivityListProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :activity_list_projects do |t|
      t.references :activity_list_daily, null: false, index: true, foreign_key: true
      t.string :project_id, null: false, index: true
      t.timestamps
    end

    add_foreign_key :activity_list_projects, :projects
  end
end
