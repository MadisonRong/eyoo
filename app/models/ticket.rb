class Ticket < ActiveRecord::Base
  belongs_to :business
  belongs_to :scenic
  belongs_to :order
  belongs_to :ticketType
  belongs_to :admin

  # 获取分页排序待审核商品列表
  scope :get_json_status_list, ->(current_admin_id, page, rows, sort_column, sort){
    sort_column = "id" if sort_column.nil? || sort_column == ""
    # current_page = page
    # page = (page.to_i-1) * rows.to_i
    # tickets = Ticket.find_by_sql(["select a.id,a.`name`,a.price,b.name scenic,a.description,
    #   a.ticket_type,a.created_at from tickets a join scenics b on a.scenic_id=b.id where a.status=0 
    #   and sys_admin_id=? order by a.#{sort_column} #{sort} limit #{page},#{rows}", admin_id])
    case sort
    when "asc"
      tickets = Admin.find(current_admin_id).tickets.where(status: 0).page(page).per(rows).order(sort_column)
    when "desc"
      tickets = Admin.find(current_admin_id).tickets.where(status: 0).page(page).per(rows).order(sort_column).reverse_order
    end
    # tickets_count = Ticket.find_by_sql(["select * from tickets a join scenics b on 
    #   a.scenic_id=b.id where a.status=0 and sys_admin_id=?", admin_id])
    tickets_count = Admin.find(current_admin_id).tickets.where(status: 0).count
    # binding.pry
    tickets_hash = Hash.new
    tickets_hash[:records] = tickets_count
    tickets_hash[:total] = (tickets_count / rows.to_i) + 1
    tickets_hash[:page] = page
    tickets_hash[:rows] = tickets
    return tickets_hash
  }

  # 审核通过商品
  scope :get_pass, ->(id){
    ticket = Ticket.find(id)
    ticket.update_attributes({
      status: 1,
      status_time: Time.now
      })
  }

  # 获取分页排序的商品列表(不一定通过审核的)
  scope :get_list, ->(current_business_id, page, rows, sort_column, sort){
    # if sort_column.nil? || sort_column == ""
    #   sort_column = "tickets.id" 
    # else
    #   sort_column = "tickets."+sort_column
    # end
    sort_column = "id" if sort_column.nil? || sort_column == ""
    # current_page = page
    # page = (page.to_i - 1) * rows.to_i
    case sort
    when "asc"
      tickets = Business.find(current_business_id).tickets.page(page).per(rows).order(sort_column)
    when "desc"
      tickets = Business.find(current_business_id).tickets.page(page).per(rows).order(sort_column).reverse_order
    end
    tickets_count = Business.find(current_business_id).tickets.count
    tickets_hash = Hash.new
    tickets_hash[:records] = tickets_count
    tickets_hash[:total] = (tickets_count.to_i / rows.to_i) + 1
    tickets_hash[:page] = page
    tickets_hash[:rows] = tickets
    return tickets_hash
  }
end