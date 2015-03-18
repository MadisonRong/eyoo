class ScenicType < ActiveRecord::Base
  has_many :scenics
  
  scope :get_options, ->(){
    ScenicType.all
  }
end
