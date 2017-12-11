class CreateIssueLists < ActiveRecord::Migration[5.1]
  def change
    create_table :issue_lists do |t|
      t.string :project_id, null: false, index: true

      t.timestamps
    end

    add_foreign_key :issue_lists, :projects
  end
end
