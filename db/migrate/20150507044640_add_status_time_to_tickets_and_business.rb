class AddStatusTimeToTicketsAndBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :status_time, :time 
    add_column :tickets, :status_time, :time
  end
end
