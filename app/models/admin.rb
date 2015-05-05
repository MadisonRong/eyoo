class Admin < ActiveRecord::Base
  # has_secure_password
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  rolify

  has_many :businesses
  has_many :tickets

  scope :get_admins, ->(page, rows, sort_column, sort){
    sort_column = "id" if sort_column.nil? && sort_column == ""
    admins = Array.new
    case sort
    when "asc"
      admins = Admin.with_role(:platform_admin).page(page).per(rows).order(sort_column)
    when "desc"
      admins = Admin.with_role(:platform_admin).page(page).per(rows).order(sort_column).reverse_order
    end
    admins_count = Admin.with_role(:platform_admin).size
    admins_hash = Hash.new
    admins_hash[:records] = admins_count
    admins_hash[:total] = (admins_count / rows.to_i) + 1
    admins_hash[:page] = page
    admins_hash[:rows] = admins
    return admins_hash
  }

  # 删除管理员
  scope :del_admin, ->(id){
    Admin.connection.transaction do
    # 查出管理员
    admin = Admin.includes("businesses", "tickets").find(id)
    # 获取该管理员审核的商家和商品
    businesses = admin.businesses
    tickets = admin.tickets
    # 删除管理员
    admin.destroy
    # 获取剩余管理员的id
    admin_ids = self.get_all_admin_id
    businesses.each do |b|
      # 更新商家的管理员
      b.update_attribute(:admin_id, admin_ids[rand(admin_ids.size)])
    end
    tickets.each do |t|
      # 更新商品的管理员
      t.update_attribute(:admin_id, admin_ids[rand(admin_ids.size)])
    end
  end
  }

  # 统计当前月的工作量
  scope :admin_workload_json, ->(){
    # 返回结果的hash
    workload_hash = Hash.new
    # 所有平台管理员
    platform_admins = Admin.with_role(:platform_admin)
    # 查出所有平台管理员审核商家的工作量
    # admins=Admin.find_by_sql("select a.id,a.`name`,count(*) y from admins a join businesses b on
    #  a.id=b.sys_admin_id where date_format(b.created_at,'%Y-%m-%d')=curdate() group by a.id")
    # 审核商家工作量结果集
    admins_businesses=Array.new
    platform_admins.each do |admin|
      result = Admin.find(admin.id).businesses.by_month.group("date(businesses.created_at)").count
      hash = Hash.new
      hash[:y] = 0
      result.each do |_,v|
        hash[:y] = v
      end
      hash[:id] = admin.id
      hash[:name] = admin.name
      admins_businesses.push(hash)
    end
    # 查出所有平台管理员审核商品的工作量
    # admins=Admin.find_by_sql("select a.id,a.`name`,count(*) y from admins a join tickets b on
    #  a.id=b.sys_admin_id where date_format(b.created_at,'%Y-%m-%d')=curdate() group by a.id")
    # 审核商品工作量结果集
    admins_tickets=Array.new
    platform_admins.each do |admin|
      result = Admin.find(admin.id).tickets.by_month.group("date(tickets.created_at)").count
      hash = Hash.new
      hash[:y] = 0
      result.each do |_,v|
        hash[:y] = v
      end
      hash[:id] = admin.id
      hash[:name] = admin.name
      admins_tickets.push(hash)
    end
    # binding.pry
    workload_hash[:businesses] = admins_businesses
    workload_hash[:tickets] = admins_tickets
    return workload_hash
  }

# private
  def self.get_all_admin_id
    admins = Admin.all
    result_array = Array.new
    admins.each do |admin|
      if admin.has_role? :platform_admin
        result_array << admin.id
      end
    end
  end

end

