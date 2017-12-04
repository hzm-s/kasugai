class CreateActivityListDailies < ActiveRecord::Migration[5.1]
  def change
    create_table :activity_list_dailies do |t|
      t.date :date, null: false, index: true
      t.timestamps
    end
  end
end
