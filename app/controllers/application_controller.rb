class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    admin_top_path
  end

end
