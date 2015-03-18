json.status @status
json.msg "##"
json.content do 
  unless @user.nil?
    json.extract! @user, :id, :name, :account, :phone, :user_identity
  end
end