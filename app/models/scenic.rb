class Scenic < ActiveRecord::Base
  belongs_to :business
  has_many :tickets
  belongs_to :scenicType

end
