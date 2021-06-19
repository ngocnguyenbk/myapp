module BatchCreate
  class InvoicesController < ApplicationController
    def new
      respond_to do |format|
        format.html
        format.json do
          @form = BatchCreate::InvoicesForm.new multi_invoices[:month]
          render json: { build: @form.build_form }
        end
      end
    end

    def create
      @form = BatchCreate::InvoicesForm.new(multi_invoices[:month], multi_invoices[:multi_invoices])
      authorize @form if @form.valid?

      if @form.save
        flash[:success] = t(".success", room_numbers: @form.room_numbers.join(", "))
        render json: { status: :ok }
      else
        render json: { status: :unprocessable_entity, errors: @form.errors }
      end
    rescue Pundit::NotAuthorizedError => e
      render json: { status: :not_allow, errors: e.message }
    end

    private

    def multi_invoices
      params.require(:invoices).permit(:month, multi_invoices: {})
    end
  end
end
