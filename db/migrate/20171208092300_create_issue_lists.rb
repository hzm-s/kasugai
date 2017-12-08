class CreateIssueLists < ActiveRecord::Migration[5.1]
  def change
    create_table :issue_lists do |t|
      t.string :project_id, null: false, index: true
      t.timestamps
    end

    reversible do |dir|
      dir.up do
        execute <<-SQL
          INSERT INTO issue_lists (project_id, created_at, updated_at)
            SELECT id, NOW(), NOW() FROM projects
        SQL
      end
    end

    add_foreign_key :issue_lists, :projects
  end
end
