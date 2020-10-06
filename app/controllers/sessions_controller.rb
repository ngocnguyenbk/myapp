class SessionsController < Devise::SessionsController
  layout "login"

  def create
    return super_create if resource_params[:email].present? && resource_params[:password].present?

    set_flash_message!(:email_alert, :email_blank) if resource_params[:email].blank?
    set_flash_message!(:password_alert, :password_blank) if resource_params[:password].blank?
    redirect_to new_user_session_path
  end

  private

  def super_create
    self.resource = warden.authenticate!(auth_options)
    respond_with resource, location: root_path
  end
end
