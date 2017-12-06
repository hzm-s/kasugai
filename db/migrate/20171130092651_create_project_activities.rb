class CreateProjectActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :project_activities do |t|
      t.references :activity_list_project, null: false, index: true, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :activity, null: false
      t.datetime :created_at, null: false
    end
  end
end
