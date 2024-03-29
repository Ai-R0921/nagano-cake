class ApplicationController < ActionController::Base
  before_action :authenticate_admin!, if: :admin_url
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_q

  def admin_url
    request.fullpath.include?("/admin")
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number])
  end

  def after_sign_in_path_for(resource)
    case resource
    when Customer
      root_path
    when Admin
      admin_top_path
    end
  end

  def after_sign_out_path_for(resource)
    case resource
    when :customer
      root_path
    when :admin
      new_admin_session_path
    end
  end

  def set_q
    @q = Item.ransack(params[:q])
  end

end
