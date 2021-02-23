class InvoicesController < ApplicationController
  before_action :invoice, only: [:show]

  def index
    @presenter = InvoicesPresenter.new(params)
    respond_to do |format|
      format.html
      format.json do
        render json: InvoiceListSerializer.new(data: @presenter.invoices).generate
      end
    end
  end

  def show
    respond_to do |format|
      format.html do
        render layout: false
      end

      format.json do
        render json: {
          invoice: InvoiceSerializer.new(invoice)
        }
      end
    end
  end

  private

  def invoice
    @invoice = Invoice.find(params[:id])
  end
end
