class CreateScenicTypes < ActiveRecord::Migration
  def change
    create_table :scenic_types do |t|
      t.string   "name", limit: 255, null: false
      t.timestamps null: false
    end
  end
end
