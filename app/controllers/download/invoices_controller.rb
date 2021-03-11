module Download
  class InvoicesController < ApplicationController
    before_action :invoice, only: [:show]

    def show
      service = DownloadInvoiceService.new(invoice)
      service.perform
      send_file service.file_path, disposition: "attachment"
    end

    private

    def invoice
      @invoice = Invoice.find(params[:id])
    end
  end
end
