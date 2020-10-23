class FloorsController < ApplicationController
  def index
    @presenter = FloorsPresenter.new(params)

    respond_to do |format|
      format.html
      format.json do
        render json: FloorListSerializer.new(data: @presenter.floors).generate
      end
    end
  end
end
