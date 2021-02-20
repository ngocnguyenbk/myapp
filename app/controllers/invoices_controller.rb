class InvoicesController < ApplicationController
  def index
    @presenter = InvoicesPresenter.new(params)
    respond_to do |format|
      format.html
      format.json do
        render json: InvoiceListSerializer.new(data: @presenter.invoices).generate
      end
    end
  end
end
