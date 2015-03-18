namespace :db do
  desc "add some random data of order"
  task order: :environment do
    make_order
  end
end

def make_order
  (rand(1000)+1).times do |n|
    order = Order.create!(
      user_id: rand(User.count)+1,
      money: 1,
      ticket_id: rand(Ticket.count)+1,
      status: 0,
      user_number: 1,
      business_id: rand(Business.count)+1
    )
  end
end