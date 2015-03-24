class Scenic < ActiveRecord::Base
  belongs_to :business
  has_many :tickets
  belongs_to :scenicType

  scope :get_options, ->(current_business_id){
    Business.find(current_business_id).scenic
  }
end
