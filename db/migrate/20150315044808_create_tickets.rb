class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string   "name",         limit: 255, null: false
      t.float    "price",        limit: 24, null: false
      t.integer  "scenic_id",    limit: 4, null: false
      t.string   "picture",      limit: 255
      t.text     "description",  limit: 65535
      t.integer  "ticket_type_id",  limit: 4, null: false
      t.integer  "status",       limit: 4, default: 0
      t.integer  "admin_id", limit: 4
      t.integer  "business_id",  limit: 4, null: false
      t.timestamps null: false
    end
  end
end
