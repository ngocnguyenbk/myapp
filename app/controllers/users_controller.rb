class UsersController < ApplicationController
  before_action :user, only: [:update, :destroy]

  def index
    @presenter = UsersPresenter.new(params)

    respond_to do |format|
      format.html
      format.json do
        render json: UserListSerializer.new(data: @presenter.users).generate
      end
    end
  end

  def update
    @form = UsersForm.new(user_params)
    @form.record = @user
    @form.save
  end

  def destroy
    @form = UsersForm.new
    @form.record = @user
    @form.destroy
  end

  private

  def user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:id, :birthday, :email, :first_name, :last_name, :phone)
  end
end
