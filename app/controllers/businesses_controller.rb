class BusinessesController < ApplicationController
  before_action :authenticate_business!
  def index
    
  end

  def show
    render nothing: true
  end
end
