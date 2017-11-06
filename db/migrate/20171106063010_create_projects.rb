class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects, id: :string do |t|
      t.string :name, null: false
      t.string :description
      t.datetime :created_at, null: false
    end
  end
end
