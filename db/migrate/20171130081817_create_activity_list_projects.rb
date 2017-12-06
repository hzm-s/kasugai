class CreateActivityListProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :activity_list_projects do |t|
      t.date :date, null: false
      t.string :project_id, null: false, index: true
      t.timestamps
    end

    add_foreign_key :activity_list_projects, :projects
  end
end
