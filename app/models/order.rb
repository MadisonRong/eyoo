class Order < ActiveRecord::Base
  belongs_to :business
  has_one :ticket
  belongs_to :user

  scope :count_order, ->(current_business_id){
    time = Time.new
    year_month = time.strftime("%Y-%m")
    businesses_result = Business.find(current_business_id).orders.by_month.group("date(orders.created_at)").count
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
