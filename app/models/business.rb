class Business < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :tickets
  has_one :scenic
  has_many :orders
  belongs_to :admin

  # 获取分页排序待审核商家列表
  scope :get_json_status_list, ->(current_admin_id, page, rows, sort_column, sort){
    sort_column = "id" if sort_column.nil? || sort_column == ""
    # current_page = page
    # page = (page.to_i - 1) * rows.to_i
    # businesses = Business.find_by_sql(["select id, name, operating_license, legal_person_name, 
    #   legal_person_photo, created_at from businesses where business_status=0 and sys_admin_id=? 
    #   order by #{sort_column} #{sort} limit #{page},#{rows}", admin_id])
    case sort
    when "asc"
      businesses = Admin.find(current_admin_id).businesses.where(business_status: 0).page(page).per(rows).order(sort_column)
    when "desc"
      businesses = Admin.find(current_admin_id).businesses.where(business_status: 0).page(page).per(rows).order(sort_column).reverse_order
    end
    # businesses_count = Business.find_by_sql(["select id, name, operating_license, legal_person_name,
    #  legal_person_photo, created_at from businesses where business_status=0 and sys_admin_id=?",
    #   admin_id])
    businesses_count = Admin.find(current_admin_id).businesses.where(business_status: 0).count
    businesses_hash = Hash.new
    businesses_hash[:records] = businesses_count
    businesses_hash[:total] = (businesses_count / rows.to_i) + 1
    businesses_hash[:page] = page
    businesses_hash[:rows] = businesses
    return businesses_hash
  }

  # 通过审核商家
  scope :get_pass, ->(id){
    business = Business.find(id)
    business.update_attribute(:business_status, 1)
  }

  # 获取分页排序的商家列表
  scope :get_json_list, ->(current_admin_id, page, rows, sort_column, sort){
    sort_column= "id" if sort_column.nil? || sort_column==""
    # current_page=page
    # page=(page.to_i-1)*rows.to_i
    # businesses=Business.find_by_sql(["select id, name, operating_license, legal_person_name, 
    #   legal_person_photo, created_at from businesses where business_status=1 and sys_admin_id=? 
    #   order by #{sort_column} #{sort} limit #{page},#{rows}", admin_id])
    case sort
    when "asc"
      businesses = Admin.find(current_admin_id).businesses.where(business_status: 1).page(page).per(rows).order(sort_column)
    when "desc"
        businesses = Admin.find(current_admin_id).businesses.where(business_status: 1).page(page).per(rows).order(sort_column).reverse_order
    end
    # businesses_count=Business.find_by_sql(["select id, name, operating_license, legal_person_name, 
    #   legal_person_photo, created_at from businesses where business_business_status=1 and sys_admin_id=?", 
    #   admin_id])
    businesses_count = Admin.find(current_admin_id).businesses.where(business_status: 1).count
    businesses_hash = Hash.new
    businesses_hash[:records] = businesses_count
    businesses_hash[:total] = (businesses_count / rows.to_i) + 1
    businesses_hash[:page] = page
    businesses_hash[:rows] = businesses
    return businesses_hash
  }

  # 统计商家
  scope :count_business, ->(){
=begin
select date_format(created_at,'%d') day,count(*) mount from businesses 
  where date_format(created_at, '%Y-%m')=date_format(curdate(),'%Y-%m') group by day
=end
    time = Time.new
    year_month = time.strftime("%Y-%m")
    # businesses = Business.select("date_format(created_at,'%d') day,count(*) mount").
    # where(["date_format(created_at, '%Y-%m')=?", year_month]).group("day").order("day")
    businesses_result = Business.by_month.group("date(businesses.created_at)").count
    # 将查询结果转换为数组
    businesses = Array.new
    businesses_result.each do |k, v|
      if k.class == Date
        day = k.strftime("%d")
      else
        day = DateTime.parse(k).strftime("%d")
      end
      result_hash = Hash.new
      result_hash[:day] = day
      result_hash[:mount] = v
      businesses.push(result_hash)
    end
    #查询结果集的迭代指针
    iterator = 0;
    #暂时先这样，应该要再写个小算法去计算闰年和每个月的天数
    month_hash = { "01" => 31, "02" => 28, "03" => 31, "04" => 30, "05" => 31, "06" => 30, "07" => 31, "08" => 31, "09" => 30, "10" => 31, "11" => 30, "12" => 31 }
    month = time.strftime("%m")
    business_array = Array.new
    1.upto(month_hash[month]) do |d|
      if iterator < businesses.length && businesses[iterator][:day].to_i == d
        business_array.push(businesses[iterator][:mount])
        iterator += 1
      else
        business_array.push(0)
      end
    end
    return business_array
  }
end
