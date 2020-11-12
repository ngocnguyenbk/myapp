class SessionsController < Devise::SessionsController
  layout "login"

  def create
    return super_create if resource_params[:email].present? && resource_params[:password].present?

    set_flash_message!(:danger, :email_blank) if resource_params[:email].blank?
    set_flash_message!(:danger, :password_blank) if resource_params[:password].blank?
    redirect_to new_admin_session_path
  end

  private

  def super_create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:success, :success)
    respond_with resource, location: floors_path
  end
end
