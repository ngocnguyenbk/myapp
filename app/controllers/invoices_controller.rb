class InvoicesController < ApplicationController
  before_action :invoice, only: [:show, :update, :destroy]

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

  def new
    @form = InvoiceForm::New.new(new_invoice_params)
    respond_to do |format|
      format.html
      format.json do
        render json: { build: @form.build_form }
      end
    end
  end

  def create
    @form = InvoiceForm::New.new(invoice_params)
    authorize @form if @form.valid?

    if @form.save
      flash[:success] = t(".success")
      render json: { status: :ok }
    else
      render json: { status: :unprocessable_entity, errors: @form.errors }
    end
  rescue Pundit::NotAuthorizedError => _e
    render json: { status: :not_allow,
                   errors: t(".had_invoice", room_number: @form.contract.room_room_number, month: @form.month) }
  end

  def update
    @form = InvoiceForm::Edit.new(update_invoice_params)
    @form.record = @invoice
    if @form.update
      render json: { status: :ok, message: "Success", step: update_invoice_params[:step] }
    else
      render json: { status: :unprocessable_entity, errors: @form.errors, step: update_invoice_params[:step] }
    end
  end

  def destroy
    @form = InvoiceForm::Destroy.new
    @form.record = @invoice
    @form.destroy
  end

  private

  def invoice
    @invoice = Invoice.find(params[:id])
  end

  def invoice_params
    params.require(:invoices).permit(:month, :room_id, :day_used_per_month, :electric_start, :electric_end,
                                     :water_start, :water_end, :unit_price_internet, :unit_price_parking_fee, :quantity_parking,
                                     :unit_price_service_fee, :electric_unit_price, :water_unit_price, :reduce, :total)
  end

  def update_invoice_params
    params.require(:invoices).permit(:id, :step, :day_used_per_month, :electric_start, :electric_end,
                                     :water_start, :water_end, :unit_price_internet, :unit_price_parking_fee, :quantity_parking,
                                     :unit_price_service_fee, :reduce, :total)
  end

  def new_invoice_params
    params.require(:invoice).permit(:room_id, :month) if params.key?(:invoice)
  end
end
