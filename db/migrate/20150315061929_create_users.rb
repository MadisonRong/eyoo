class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   "account",         limit: 255,             null: false
      t.string   "name",            limit: 255,             null: false
      t.string   "password_digest", limit: 255,             null: false
      t.string   "phone",           limit: 255,             null: false
      t.integer  "user_identity",   limit: 4,   default: 0
      t.timestamps null: false
    end
  end
end
