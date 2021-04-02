module InvoiceForm
  class NewPolicy < ApplicationPolicy
    def create?
      !record.invoice_in_month?
    end
  end
end
