class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer  "user_id",     limit: 4, null: false
      t.float    "money",       limit: 24, null: false
      t.integer  "ticket_id",   limit: 4, null: false
      t.integer  "business_id", limit: 4, null: false
      t.integer  "status",      limit: 4,   default: 0
      t.string   "user_number", limit: 255
      t.timestamps null: false
    end
  end
end
