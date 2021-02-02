# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  
  def new_guest
    admin = Admin.guest
    sign_in admin
    redirect_to admin_genres_path, notice: 'ゲスト管理者としてログインしました。'
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end


  #　管理人ログイン時とログアウトの遷移先指定
  protected

  def after_sign_in_path_for(resource)
    admin_genres_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
