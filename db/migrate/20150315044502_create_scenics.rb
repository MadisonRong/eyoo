class CreateScenics < ActiveRecord::Migration
  def change
    create_table :scenics do |t|
      t.string   "name",           limit: 255, null: false
      t.string   "picture",        limit: 255, null: false
      t.string   "manager_name",   limit: 255, null: false
      t.string   "manager_number", limit: 255, null: false
      t.integer  "business_id",    limit: 4
      t.integer  "scenic_type_id",    limit: 4
      t.datetime "start_time"
      t.datetime "end_time"
      t.timestamps null: false
    end
  end
end
