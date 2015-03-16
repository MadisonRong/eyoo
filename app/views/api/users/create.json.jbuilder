json.status @status
json.msg "##"
json.content do 
  unless @user.nil?
    json.id @user.id
    json.name @user.name
    json.account @user.account
    json.phone @user.phone
    json.user_identity @user.user_identity
    json.extract! @user, :id, :name, :account, :phone, :user_identity
  end
end