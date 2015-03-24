class ScenicsController < ApplicationController
  before_action :authenticate_business!, only:[:scenics_option, :select]
  def scenics_option
    @scenic_types=ScenicType.get_options
  end

  def select
    @scenic = Scenic.get_options(current_business.id)
  end
end
