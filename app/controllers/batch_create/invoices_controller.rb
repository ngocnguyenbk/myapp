module BatchCreate
  class InvoicesController < ApplicationController
    def new
      @form = BatchCreate::InvoicesForm.new

      respond_to do |format|
        format.html
        format.json do
          render json: { build: @form.build_form }
        end
      end
    end

    def create
      @form = BatchCreate::InvoicesForm.new(multi_invoices[:multi_invoices])
      @form.save

      render json: { status: :ok }
    end

    private

    def multi_invoices
      params.require(:invoices).permit(multi_invoices: {})
    end
  end
end
