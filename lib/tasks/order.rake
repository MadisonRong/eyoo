namespace :db do
  desc "add some random data of order"
  task order: :environment do
    make_order
  end
end

def make_order
	business_ids = get_all_businesses_id
	  (rand(1000)+1).times do |n|
	    order = Order.create!(
	      user_id: rand(User.count)+1,
	      money: 1,
	      ticket_id: rand(Ticket.count)+1,
	      status: 0,
	      user_number: 1,
	      business_id: business_ids[rand(business_ids.size)]
	    )
	  end
end

def get_all_businesses_id
	businesses = Business.all
	result_array = Array.new
	businesses.each do |b|
		result_array << b.id
	end
end