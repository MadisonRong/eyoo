namespace :db do
	desc "fill some sample data"
	task sample: :environment do
		make_admins
    make_users
		make_scenics_and_tickets
		make_scenic_and_tickets_type
		make_orders
	end
end

def make_admins
	#创建系统管理员
	system_admin = Admin.create!(
      name: "MadisonRong",
		  email: "MadisonRong@rong.com",
		  password: "123456789",
		  password_confirmation: "123456789"
		)
	#创建平台管理员
	3.times do |n|
		platform_admin=Admin.create!(
      name: "Fat.new#{n}",
		  email: "Fat.new#{n}@rong.com",
		  password: "123456789",
		  password_confirmation: "123456789"
		)
	end
	#创建商家
	99.times do |n|
		name = Faker::Name.name
		bussiness=Business.create!(
			email: "b#{n}@rong.com",
		  name: name,
		  password: "123456789",
		  password_confirmation: "123456789",
			operating_license: "/assets/user.jpg",
			legal_person_name: "Fat.new",
			legal_person_photo: "/assets/avatar#{rand(4)+1}.png",
			business_status: 0,
			platform_admin_id: (n%3)+2
		)
	end
end

def make_scenics_and_tickets
	99.times do |n|
		name = Faker::Name.name
		scenic=Scenic.create!(
			name: name,
			picture: "",
			manager_name: "Fat.new",
			manager_number: "123456789123456789",
			business_id: n+1
		)
		ticket=Ticket.create!(
			name: name,
			price: 1,
			scenic_id: scenic.id,
			picture: "",
			description: "",
			ticket_type_id: (n%3)+1,
			status: 0,
			platform_admin_id: (n%3)+2,
			business_id: n+1
		)
	end
end

def make_scenic_and_tickets_type
	tickets_type1=TicketType.create!(name: "漂流")
	tickets_type2=TicketType.create!(name: "滑雪")
	tickets_type3=TicketType.create!(name: "游乐场")
	tickets_type4=TicketType.create!(name: "温泉")
	tickets_type5=TicketType.create!(name: "名山胜水")
	tickets_type6=TicketType.create!(name: "古镇")
	scenic_type1=ScenicType.create!(name: "国内游")
	scenic_type2=ScenicType.create!(name: "自助游")
	scenic_type3=ScenicType.create!(name: "出境游")
	scenic_type4=ScenicType.create!(name: "游轮")
end

def make_orders
	990.times do |n|
		order = Order.create!(
      user_id: rand(99)+1,
      money: 1,
      ticket_id: rand(99)+1,
      status: 0,
      user_number: 1,
      business_id: rand(99)+1
		)
	end
end

def make_users
  99.times do |n|
    name = Faker::Name.name
    user = User.create!(
      account: "123456#{n}",
      name: name,
      password: "123456789",
      password_confirmation: "123456789",
      phone: "123456789#{n}",
      user_identity: 0
    )
  end
end
