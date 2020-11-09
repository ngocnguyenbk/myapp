class UsersController < ApplicationController
  before_action :user, only: [:update, :destroy]

  USER_PARAMETERS = [:id, :birthday, :email, :first_name, :last_name, :phone, :identity_card, :room_id].freeze

  def index
    @presenter = UsersPresenter.new(params)

    respond_to do |format|
      format.html
      format.json do
        render json: UserListSerializer.new(data: @presenter.users).generate
      end
    end
  end

  def new; end

  def create
    @form = BatchCreate::UsersForm.new(multi_user_params)
    if @form.save
      flash[:success] = t(".success")
      render json: { status: :ok }
    else
      render json: { status: :unprocessable_entity, errors: @form.error_child }
    end
  end

  def update
    @form = UsersForm.new(user_params.merge(room_id: @user.room_id))
    @form.record = @user
    if @form.save
      render json: { user: UserSerializer.new(@form.record), status: :ok, message: "Success" }
    else
      render json: { status: :unprocessable_entity, error: @form.errors }
    end
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
    params.require(:user).permit(*USER_PARAMETERS)
  end

  def multi_user_params
    params.require(:multi_users).permit(user_attributes: USER_PARAMETERS)
  end
end
