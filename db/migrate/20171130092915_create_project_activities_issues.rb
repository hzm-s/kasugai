class CreateProjectActivitiesIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :project_activities_issues do |t|
      t.references :project_activity, null: false, index: true, foreign_key: true
      t.string :issue_id, null: false
      t.string :title, null: false
    end
  end
end
