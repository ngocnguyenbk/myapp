class InvoicesController < ApplicationController
  def index; end

  def new
    @form = BatchCreate::InvoicesForm.new
    render json: { data: @form.build_form }
  end
end
