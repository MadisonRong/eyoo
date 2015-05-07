class AdminsController < ApplicationController
  require 'bcrypt'
  before_action :authenticate_admin!

  def index;end

  def show
    @admin = Admin.find(params[:id])
    respond_to do |format|
      format.html { render nothing: true }
      format.js
    end
  end

  def admin_update_name
    admin = Admin.find(current_admin.id)
    @result = false
    #update admin name
    name = params[:admin][:name]
    @error_msg = Hash.new
    unless name.blank?
      admin.update_attribute(:name, name)
      @result = true
    else
      @error_msg[:name] = "名字不能为空"
    end
    respond_to do |format|
      format.html { render nothing: true }
      format.js { render partial: 'shared/op_result' }
    end
  end

  def admin_update_password
    admin = Admin.find(current_admin.id)
    @result = false
    @error_msg = Hash.new
    #update admin password
    password_old = params[:admin][:password_old]
    password_new = params[:admin][:password_new]
    password_new_confirmation = params[:admin][:password_new_confirmation]
    unless password_old.blank? && password_new.blank? && password_new_confirmation.blank?
      if password_new == password_new_confirmation 
        if admin.valid_password?(password_old)
          #generate new password for admin accroding to given from front-end
          admin.update_attribute(:encrypted_password, BCrypt::Password.create(password_new))
          @result = true
        else
          @error_msg[:error_password] = "原密码错误"
        end
      else
        @error_msg[:old_password] = "新密码和确认新密码不一致"
      end
    else
      @error_msg[:is_nil] = "原密码，新密码和确认新密码都不能为空"
    end
    respond_to do |format|
      format.html { render nothing: true }
      format.js { render partial: 'shared/op_result' }
    end
  end

  def admin_update
    @result = false
    case params[:oper]
    when 'edit'
      admin = Admin.find(params[:id])
      #update admin name
      name = params[:name]
      unless name.nil?
        admin.update_attribute(:name, name)
        @result = true
      end
    when 'add'
      #create admin
      name = params[:name]
      email = params[:email]
      admin = Admin.create!(
        name: name,
        email: email,
        password: "123456789",
        password_confirmation: "123456789"
      )
      admin.add_role(:platform_admin)
      @result = true
    when 'del'
      #delete admin
      @result=Admin.del_admin(params[:id])
    end

    respond_to do |format|
      format.html { render nothing: true }
      format.js
    end
  end

  def admin_statistics_workload
    respond_to do |format|
      format.js
    end
  end

  def list
    @title = "管理平台管理员"
    respond_to do |format|
      format.html { render nothing: true }
      format.js
    end
  end

  def jsonlist
    @admins_hash = Admin.get_admins(params[:page], params[:rows], params[:sidx], params[:sord])
    render json: @admins_hash
  end

  def admin_workload_json
    @admins = Admin.admin_workload_json
    render json: @admins
  end

  private
  def admin_params
    params.require(:admin).permit(:oper, :id, :name, :email, :password, :password_confirmation)
  end
end
