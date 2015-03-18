class TicketType < ActiveRecord::Base
  has_many :tickets
  
  scope :get_options, ->(){
    TicketType.all
  }
end
