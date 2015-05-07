namespace :fix do
  desc "fix pic"
  task pic: :environment do
    fix_pic
  end
end

def fix_pic
  businesses = Business.all
  # tickets = Ticket.all
  # scenics = Senic.all
  businesses.each do |b|
    new_operating_license = b.operating_license.split("/assets/").join("")
    new_legal_person_photo = b.legal_person_photo.gsub("/assets/", "avatars/")
    b.update_attributes!({
      operating_license: new_operating_license,
      legal_person_photo: new_legal_person_photo
      })
  end
end