class CreateBaseRegions < ActiveRecord::Migration
  def change
    create_table :base_regions do |t|
      t.integer "parentid", null: false, comment: "父级id"
      t.string "name", null: false, comment: "城市名"
      t.string "code", null: false, comment: "编码"
      t.string "parent", null: false, comment: "父级编码"
      t.integer "region_type", null: false, comment: "0-国家，1-区域，2-省，3-市，4-县"
      t.integer "status", null: false, comment: "是否启用"
      t.integer "iscity", null: false, comment: "是否为市级"
      t.string "pingyin", null: false, comment: "拼音首字母"
      t.timestamps null: false
    end
    add_index(:base_regions, :parentid)
    add_index(:base_regions, :region_type)
    add_index(:base_regions, :iscity)
  end
end
