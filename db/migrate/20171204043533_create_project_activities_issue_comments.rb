class CreateProjectActivitiesIssueComments < ActiveRecord::Migration[5.1]
  def change
    create_table :project_activities_issue_comments do |t|
      t.references :project_activity, null: false, index: true, foreign_key: true
      t.string :issue_id, null: false
      t.string :issue_title, null: false
    end
  end
end
