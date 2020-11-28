class RegistrationsController < Devise::RegistrationsController
  before_action :only_to_development

  layout "login"

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      flash.now[:success] = t(".success")
      redirect_to new_admin_session_path
    else
      flash.now[:danger] = t(".failure")
      render :new
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:full_name, :email, :birthday, :role, :phone,
                                  :password, :password_confirmation)
  end
end
