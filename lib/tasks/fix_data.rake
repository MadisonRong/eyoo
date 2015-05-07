namespace :fix do
  desc "fix some data in database"
  task data: :environment do
    fix_data
  end
end

def fix_data
  businesses = Business.all
  tickets = Ticket.all
  admin_ids = get_all_admin_id
  businesses.each do |b|
    unless admin_ids.include? b.admin_id
      b.update_attribute(:admin_id, admin_ids[rand(admin_ids.size)])
      p "found one and fixeds"
    end
  end
  tickets.each do |t|
    unless admin_ids.include? t.admin_id
      t.update_attribute(:admin_id, admin_ids[rand(admin_ids.size)])
      p "found one and fixeds"
    end
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