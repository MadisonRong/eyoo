class OrdersController < ApplicationController
  before_action :authenticate_business!, only:[:statistics]
  def statistics
    @orders = Order.count_order(current_business.id)
    @categories = ""
    1.upto(@orders.length) do |n|
      @categories += n.to_s
      if n < @orders.length
        @categories += ","
      end
    end
    # render json: @orders
  end
end
