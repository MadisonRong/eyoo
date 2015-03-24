class BaseRegion < ActiveRecord::Base
  # REGION_TYPE: 0-国家，1-区域，2-省，3-市，4-县

  # 获取省份信息
  scope :get_provinces, ->(){
    select(:id, :name, :code).where(region_type: 2)
  }

  # 获取城市信息
  scope :get_cities, ->(){
    select(:id, :name).where(region_type: 3)
  }

  # 根据省份找出城市
  scope :get_city, ->(province_code){
    select(:id, :name).where(parent: province_code, iscity: 1)
  }
end
