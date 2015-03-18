namespace :db do
  desc "add some random data of business"
  task business: :environment do
    make_businesses
  end
end

def make_businesses
  (rand(10)+1).times do |n|
    name = Faker::Name.name
    last_id = Business.last.id
    bussiness=Business.create!(
      email: "b#{n+last_id}@rong.com",
      name: name,
      password: "123456789",
      password_confirmation: "123456789",
      operating_license: "/assets/user.jpg",
      legal_person_name: "Fat.new",
      legal_person_photo: "/assets/avatar#{rand(4)+1}.png",
      business_status: 0,
      admin_id: (n%3)+2
    )
  end
end