class AddProvinceAndCityToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :province, :integer
    add_column :tickets, :city, :integer
  end
end
