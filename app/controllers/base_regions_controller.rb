class BaseRegionsController < ApplicationController
  def get_provinces
    @provinces = BaseRegion.get_provinces
  end

  def get_cities
    @cities = BaseRegion.get_cities
  end

  def get_city
    @city = BaseRegion.get_city(params[:province_code])
  end
end
