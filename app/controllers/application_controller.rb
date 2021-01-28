class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(resource)
  end
 
  
  def check_guest
    email = resource&.email || params[:user][:email].downcase
    if email == 'test@example.com'
      redirect_to root_path, alert: 'ゲストユーザーの変更・削除はできません。'
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up, keys: [
        :last_name, :first_name, :last_name_kana, :first_name_kana,
        :zipcode, :address, :phone_number, :email,
      ]
    )
    devise_parameter_sanitizer.permit(:sign_in,keys: [:email])
  end
end
