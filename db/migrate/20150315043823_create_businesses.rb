class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string   "name",               limit: 255, null: false
      t.string   "operating_license",  limit: 255, null: false
      t.string   "legal_person_name",  limit: 255, null: false
      t.string   "legal_person_photo", limit: 255, null: false
      t.integer  "business_status",    limit: 4,   default: 0
      t.integer  "platform_admin_id",       limit: 4
      t.timestamps null: false
    end
  end
end
