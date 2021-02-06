class InvoiceForm < BaseForm
  attr_reader :current_date

  def initialize
    @current_date = Date.current
  end
end
