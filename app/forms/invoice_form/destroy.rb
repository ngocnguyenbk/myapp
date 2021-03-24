module InvoiceForm
  class Destroy < Base
    def destroy
      ActiveRecord::Base.transaction do
        invoice.item_electric.destroy
        invoice.item_internet.destroy
        invoice.item_parking_fee.destroy
        invoice.item_service.destroy
        invoice.item_water.destroy
        invoice.destroy
      end
    end

    private

    def invoice
      @invoice ||= record
    end
  end
end
