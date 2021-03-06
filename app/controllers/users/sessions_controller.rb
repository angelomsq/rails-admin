# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  layout 'home'
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  protected

  def configure_sign_in_params
    # devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:login, :password, :remember_me)
    end
  end
end
