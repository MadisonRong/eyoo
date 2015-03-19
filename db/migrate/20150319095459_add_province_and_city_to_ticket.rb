class AddProvinceAndCityToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :province, :string
    add_column :tickets, :city, :string
  end
end
