class User < ActiveRecord::Base
  has_many :orders
  has_secure_password

  scope :register, ->(params){
    User.create!(
      account: params[:email],
      name: params[:name],
      phone: params[:phone],
      user_identity: 0,
      password: "123456789",
      password_confirmation: "123456789"
    )
  }
end
