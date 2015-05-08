class RemoveStatusTimeFromBusiness < ActiveRecord::Migration
  def change
    remove_column :businesses, :status_time
  end
end
