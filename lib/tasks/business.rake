namespace :db do
  desc "add some random data of business"
  task business: :environment do
    make_businesses
  end
end

def make_businesses
  admin_ids = get_all_admin_id
  (rand(10)+1).times do |n|
    name = Faker::Name.name
    last_id = Business.last.id
    bussiness=Business.create!(
      email: "b#{n+last_id+1}@eyoo.com",
      name: name,
      password: "123456789",
      password_confirmation: "123456789",
      operating_license: "user.jpg",
      legal_person_name: "lzq",
      legal_person_photo: "avatar#{rand(4)+1}.png",
      business_status: 0,
      admin_id: admin_ids[rand(admin_ids.size)]
    )
  end
end

def get_all_admin_id
	admins = Admin.all
	result_array = Array.new
	admins.each do |admin|
             if admin.has_role? :platform_admin
                 result_array << admin.id
             end
	end
end