class UsersController < ApplicationController
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
    binding.pry
  end
end
