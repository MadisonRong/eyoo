class Ticket < ActiveRecord::Base
  belongs_to :business
  belongs_to :scenic
  belongs_to :order
  belongs_to :ticketType
end
