class ScenicsController < ApplicationController
  def scenics_option
    @scenic_types=ScenicType.get_options
  end
end
