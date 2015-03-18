class BusinessesController < ApplicationController
  before_action :authenticate_business!, only:[:index, :admin_update_name, :admin_update_password, :test, :upload]
  before_action :authenticate_admin!, only:[:status_list, :json_status_list, :pass, :admin_update, :list, :json_list, :statistics, :json_statistics]

  def index;end

  def show
    @business = Business.find(params[:id])
    respond_to do |format|
      format.html { render nothing: true }
      format.js
    end
  end

  def status_list
    @title = "审核商家"
    respond_to do |format|
      format.js 
    end
  end

  def json_status_list
    page = params[:page]
    rows = params[:rows]
    sort_column = params[:sidx]
    sort = params[:sord]
    @businesses_hash = Business.get_json_status_list(current_admin.id, page, rows, sort_column, sort)
    render json: @businesses_hash
  end

  def pass
    @result = false
    case params[:oper]
    when "del"
      @result = Business.get_pass(params[:id])
    end
    respond_to do |format|
      format.js { render partial: 'shared/op_result' }
    end
  end

  def list
    @title = "管理商家"
    respond_to do |format|
      format.js 
    end
  end

  def json_list
    page = params[:page]
    rows = params[:rows]
    sort_column = params[:sidx]
    sort = params[:sord]
    @businesses_hash = Business.get_json_list(current_admin.id, page, rows, sort_column, sort)
    render json: @businesses_hash
  end

    def admin_update_name
    business = Business.find(current_business.id)
    @result = false
    #update business name
    name = params[:business][:name]
    @error_msg = Hash.new
    unless name.blank?
      business.update_attribute(:name, name)
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
    business = Business.find(current_business.id)
    @result = false
    @error_msg = Hash.new
    #update business password
    password_old = params[:business][:password_old]
    password_new = params[:business][:password_new]
    password_new_confirmation = params[:business][:password_new_confirmation]
    if password_old.blank? || password_new.blank? || password_new_confirmation.blank?
      @error_msg[:is_nil] = "原密码，新密码和确认新密码都不能为空"
    else
      if password_new == password_new_confirmation 
        if business.valid_password?(password_old)
          #generate new password for business accroding to given from front-end
          business.update_attribute(:encrypted_password, BCrypt::Password.create(password_new))
          @result = true
        else
          @error_msg[:error_password] = "原密码错误"
        end
      else
        @error_msg[:old_password] = "新密码和确认新密码不一致"
      end
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
      business = Business.find(params[:id])
      #update business
      name = params[:name]
      legal_person_name = params[:legal_person_name]
      legal_person_photo = params[:legal_person_photo]
      unless name.nil? 
        business.update_attribute(:name, name)
        business.update_attribute(:legal_person_name, legal_person_name)
        @result = true
      end
    when 'del'
      #delete business
      @result = Business.find(params[:id]).destroy
    end
    
    respond_to do |format|
      format.js  { render partial: 'shared/op_result' }
    end
  end

  def statistics
    @businesses = Business.count_business
    @categories = ""
    1.upto(@businesses.length) do |n|
      @categories += n.to_s
      if n < @businesses.length
        @categories += ","
      end
    end
  end

  def json_statistics
    @businesses = Business.count_business
    # binding.pry
    render json: @businesses
  end

  def test
    
  end

  def upload
    uploader = PictureUploader.new
    result = uploader.store!(params[:file])
    puts uploader.url
    # binding.pry
    redirect_to uploader.url
  end
end
