class CreateProjectActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :project_activities do |t|
      t.string :project_id, null: false, index: true
      t.references :user, null: false, foreign_key: true
      t.string :activity, null: false
      t.datetime :created_at, null: false
    end

    add_foreign_key :project_activities, :projects
  end
end
