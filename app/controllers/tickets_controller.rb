class TicketsController < ApplicationController
  before_action :authenticate_admin!, only:[:status_list, :json_status_list, :pass]
  before_action :authenticate_business!, only:[:tickets_list, :tickets_json_list, :admin_update, :tickets_option]
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
    @commodity_hash=Ticket.get_json_status_list(current_admin.id, page, rows, sort_column, sort)
    render json: @commodity_hash
  end

  def pass
    @result=false
    case params[:oper]
    when "del"
      @result=Ticket.get_pass(params[:id])
    end
    respond_to do |format|
      format.js { render partial: 'shared/op_result' }
    end
  end

  def tickets_option
    @ticket_types=TicketType.get_options
  end

  def admin_update
    @result = false
    case params[:oper]
    when "add"
      ticket = Ticket.create!(
        name: params[:name],
        price: params[:price],
        scenic_id: params[:scenic_id],
        description: params[:description],
        ticket_type_id: params[:ticket_type_id],
        business_id: current_business.id,
        admin_id: current_business.admin_id,
        status: 0
      )
      @result = true unless ticket.nil?
    when "edit"
      ticket = Ticket.find(params[:id])
      ticket.update(
        name: params[:name],
        price: params[:price],
        scenic_id: params[:scenic_id],
        description: params[:description],
        ticket_type_id: params[:ticket_type_id]
      )
    when "del"
      # delete ticket
      Ticket.find(params[:id]).destroy
    end
  end

  def tickets_list
    respond_to do |format|
      format.js { render partial: 'shared/op_result' }
    end
  end

  def tickets_json_list
    page=params[:page]
    rows=params[:rows]
    sort_column=params[:sidx]
    sort=params[:sord]
    @commodity_hash=Ticket.get_list(current_business.id, page, rows, sort_column, sort)
    render json: @commodity_hash
  end

  private
    def ticket_params
      params.require(:ticket).permit(:id, :name, :price, :scenic_id, :description, :ticket_type_id, :status)
    end
end
