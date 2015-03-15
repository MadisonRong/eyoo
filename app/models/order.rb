class Order < ActiveRecord::Base
  belongs_to :business
  has_one :ticket
  belongs_to :user
end
