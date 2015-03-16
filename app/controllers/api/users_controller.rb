class Api::UsersController < Api::ApplicationController

  # register
  def create
    begin
      @user = User.register(params)
      @status = ResponseCode.success
    rescue Exception => e
      @status = ResponseCode.fail
    end
  end
end
