class TicketsController < ApplicationController
  before_action :authenticate_business!, only:[:json_status_list]
  def status_list
    @title="审核商品"
    respond_to do |format|
      format.js { render 'list' }
    end
  end

  def json_status_list
    page=params[:page]
    rows=params[:rows]
    sort_column=params[:sidx]
    sort=params[:sord]
    @commodity_hash=Ticket.new.get_json_status_list(current_admin.id, page, rows, sort_column, sort)
    render json: @commodity_hash
  end

  def pass
    @result=false
    case params[:oper]
    when "del"
      @result=Ticket.new.get_pass params[:id]
    end
    respond_to do |format|
      format.js { render 'shared/op_result' }
    end
  end

  def commodity_list
    respond_to do |format|
      format.js 
    end
  end

  def commodity_json_list
    page=params[:page]
    rows=params[:rows]
    sort_column=params[:sidx]
    sort=params[:sord]
    @commodity_hash=Ticket.new.get_list(current_admin.id, page, rows, sort_column, sort)
    render json: @commodity_hash
  end
end
