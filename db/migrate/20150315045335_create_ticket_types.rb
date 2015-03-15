class CreateTicketTypes < ActiveRecord::Migration
  def change
    create_table :ticket_types do |t|
      t.string   "name",       limit: 255, null: false
      t.float    "discount",   limit: 24
      t.timestamps null: false
    end
  end
end
